import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/customers.dart';

part 'customer_dao.g.dart';

/// All database queries related to customers
@DriftAccessor(tables: [Customers])
class CustomerDao extends DatabaseAccessor<AppDatabase> with _$CustomerDaoMixin {
  CustomerDao(super.db);

  /// Get all customers ordered by name
  Future<List<Customer>> getAllCustomers() =>
      (select(customers)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();

  /// Watch all customers (auto-updates UI when data changes)
  Stream<List<Customer>> watchAllCustomers() =>
      (select(customers)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  /// Search customers by name or phone (instant search)
  Stream<List<Customer>> searchCustomers(String query) {
    final pattern = '%$query%';
    return (select(customers)
          ..where((c) => c.name.like(pattern) | c.phone.like(pattern))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  /// Get single customer by ID
  Future<Customer> getCustomerById(int id) =>
      (select(customers)..where((c) => c.id.equals(id))).getSingle();

  /// Get recent customers (last 5 added)
  Future<List<Customer>> getRecentCustomers() =>
      (select(customers)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(5))
          .get();

  /// Add a new customer
  Future<int> addCustomer(CustomersCompanion customer) =>
      into(customers).insert(customer);

  /// Update customer
  Future<bool> updateCustomer(Customer customer) =>
      update(customers).replace(customer);

  /// Delete customer
  Future<int> deleteCustomer(int id) =>
      (delete(customers)..where((c) => c.id.equals(id))).go();
}
