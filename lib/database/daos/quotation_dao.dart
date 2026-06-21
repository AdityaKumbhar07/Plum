import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/quotations.dart';
import '../tables/quotation_items.dart';

part 'quotation_dao.g.dart';

/// Holds a quotation with its items
class QuotationWithItems {
  final Quotation quotation;
  final List<QuotationItem> items;

  QuotationWithItems({required this.quotation, required this.items});
}

/// All database queries related to quotations
@DriftAccessor(tables: [Quotations, QuotationItems])
class QuotationDao extends DatabaseAccessor<AppDatabase> with _$QuotationDaoMixin {
  QuotationDao(super.db);

  /// Create a quotation with all its items
  Future<int> createQuotation({
    required int customerId,
    required List<QuotationItemsCompanion> items,
  }) async {
    return transaction(() async {
      final quotationId = await into(quotations).insert(
        QuotationsCompanion.insert(
          customerId: customerId,
          createdAt: Value(DateTime.now().millisecondsSinceEpoch),
        ),
      );

      for (final item in items) {
        await into(quotationItems).insert(
          item.copyWith(quotationId: Value(quotationId)),
        );
      }

      return quotationId;
    });
  }

  /// Get quotation with items
  Future<QuotationWithItems> getQuotationWithItems(int quotationId) async {
    final quotation = await (select(quotations)..where((q) => q.id.equals(quotationId))).getSingle();
    final items = await (select(quotationItems)..where((qi) => qi.quotationId.equals(quotationId))).get();
    return QuotationWithItems(quotation: quotation, items: items);
  }

  /// Get all quotations for a customer
  Stream<List<Quotation>> watchQuotationsForCustomer(int customerId) =>
      (select(quotations)
            ..where((q) => q.customerId.equals(customerId))
            ..orderBy([(q) => OrderingTerm.desc(q.createdAt)]))
          .watch();

  /// Get items for a quotation
  Future<List<QuotationItem>> getItemsForQuotation(int quotationId) =>
      (select(quotationItems)..where((qi) => qi.quotationId.equals(quotationId))).get();
}
