import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/bills.dart';
import '../tables/bill_items.dart';
import '../tables/customers.dart';

part 'bill_dao.g.dart';

/// Holds a bill with all its line items and customer info
class BillWithItems {
  final Bill bill;
  final Customer customer;
  final List<BillItem> items;

  BillWithItems({required this.bill, required this.customer, required this.items});

  double get balanceDue => bill.totalAmount - bill.amountPaid;
}

/// Holds a customer with their total pending balance
class CustomerWithBalance {
  final Customer customer;
  final double totalDue;

  CustomerWithBalance({required this.customer, required this.totalDue});
}

/// All database queries related to bills and payments
@DriftAccessor(tables: [Bills, BillItems, Customers])
class BillDao extends DatabaseAccessor<AppDatabase> with _$BillDaoMixin {
  BillDao(super.db);

  /// Get next bill number (auto-increment)
  Future<int> getNextBillNumber() async {
    final result = await customSelect(
      'SELECT COALESCE(MAX(bill_number), 0) + 1 AS next_num FROM bills',
    ).getSingle();
    return result.read<int>('next_num');
  }

  /// Create a bill with all its items in one transaction
  Future<int> createBill({
    required int customerId,
    required double totalAmount,
    required bool isPaid,
    required List<BillItemsCompanion> items,
  }) async {
    return transaction(() async {
      final billNumber = await getNextBillNumber();

      final billId = await into(bills).insert(BillsCompanion.insert(
        customerId: customerId,
        billNumber: billNumber,
        totalAmount: Value(totalAmount),
        amountPaid: Value(isPaid ? totalAmount : 0.0),
        isPaid: Value(isPaid),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ));

      for (final item in items) {
        await into(billItems).insert(item.copyWith(billId: Value(billId)));
      }

      return billId;
    });
  }

  /// Get bill with its items and customer
  Future<BillWithItems> getBillWithItems(int billId) async {
    final bill = await (select(bills)..where((b) => b.id.equals(billId))).getSingle();
    final customer = await (select(customers)..where((c) => c.id.equals(bill.customerId))).getSingle();
    final items = await (select(billItems)..where((bi) => bi.billId.equals(billId))).get();
    return BillWithItems(bill: bill, customer: customer, items: items);
  }

  /// Get all bills for a customer
  Stream<List<Bill>> watchBillsForCustomer(int customerId) =>
      (select(bills)
            ..where((b) => b.customerId.equals(customerId))
            ..orderBy([(b) => OrderingTerm.desc(b.createdAt)]))
          .watch();

  /// Get all unpaid bills grouped by customer (for payment tracker)
  Future<List<CustomerWithBalance>> getCustomersWithPendingBalance() async {
    final result = await customSelect(
      '''
      SELECT c.*, SUM(b.total_amount - b.amount_paid) AS total_due
      FROM customers c
      INNER JOIN bills b ON b.customer_id = c.id
      WHERE b.is_paid = 0
      GROUP BY c.id
      HAVING total_due > 0
      ORDER BY total_due DESC
      ''',
      readsFrom: {customers, bills},
    ).get();

    return result.map((row) {
      return CustomerWithBalance(
        customer: Customer(
          id: row.read<int>('id'),
          name: row.read<String>('name'),
          phone: row.read<String>('phone'),
          address: row.read<String>('address'),
          createdAt: row.read<int>('created_at'),
        ),
        totalDue: row.read<double>('total_due'),
      );
    }).toList();
  }

  /// Mark a bill as paid
  Future<void> markBillPaid(int billId) async {
    final bill = await (select(bills)..where((b) => b.id.equals(billId))).getSingle();
    await (update(bills)..where((b) => b.id.equals(billId))).write(
      BillsCompanion(
        isPaid: const Value(true),
        amountPaid: Value(bill.totalAmount),
      ),
    );
  }

  /// Mark all bills for a customer as paid
  Future<void> markAllBillsPaidForCustomer(int customerId) async {
    final unpaidBills = await (select(bills)
          ..where((b) => b.customerId.equals(customerId) & b.isPaid.equals(false)))
        .get();

    await transaction(() async {
      for (final bill in unpaidBills) {
        await (update(bills)..where((b) => b.id.equals(bill.id))).write(
          BillsCompanion(
            isPaid: const Value(true),
            amountPaid: Value(bill.totalAmount),
          ),
        );
      }
    });
  }

  /// Get total pending balance for a customer
  Future<double> getPendingBalanceForCustomer(int customerId) async {
    final result = await customSelect(
      'SELECT COALESCE(SUM(total_amount - amount_paid), 0) AS balance FROM bills WHERE customer_id = ? AND is_paid = 0',
      variables: [Variable.withInt(customerId)],
      readsFrom: {bills},
    ).getSingle();
    return result.read<double>('balance');
  }

  /// Get recent bills (for dashboard)
  Future<List<BillWithItems>> getRecentBills({int limit = 5}) async {
    final recentBills = await (select(bills)
          ..orderBy([(b) => OrderingTerm.desc(b.createdAt)])
          ..limit(limit))
        .get();

    final result = <BillWithItems>[];
    for (final bill in recentBills) {
      final customer = await (select(customers)..where((c) => c.id.equals(bill.customerId))).getSingle();
      final items = await (select(billItems)..where((bi) => bi.billId.equals(bill.id))).get();
      result.add(BillWithItems(bill: bill, customer: customer, items: items));
    }
    return result;
  }
}
