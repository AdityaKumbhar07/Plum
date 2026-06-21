import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/saved_items.dart';

part 'saved_item_dao.g.dart';

/// All database queries for the plumber's saved charges list
@DriftAccessor(tables: [SavedItems])
class SavedItemDao extends DatabaseAccessor<AppDatabase> with _$SavedItemDaoMixin {
  SavedItemDao(super.db);

  /// Get all saved items ordered by sort order
  Future<List<SavedItem>> getAllItems() =>
      (select(savedItems)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();

  /// Watch all saved items (auto-updates UI)
  Stream<List<SavedItem>> watchAllItems() =>
      (select(savedItems)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();

  /// Add a new saved item
  Future<int> addItem(SavedItemsCompanion item) =>
      into(savedItems).insert(item);

  /// Update a saved item
  Future<bool> updateItem(SavedItem item) =>
      update(savedItems).replace(item);

  /// Delete a saved item
  Future<int> deleteItem(int id) =>
      (delete(savedItems)..where((i) => i.id.equals(id))).go();

  /// Reorder items
  Future<void> reorderItems(List<SavedItem> items) async {
    await transaction(() async {
      for (int i = 0; i < items.length; i++) {
        await (update(savedItems)..where((si) => si.id.equals(items[i].id))).write(
          SavedItemsCompanion(sortOrder: Value(i)),
        );
      }
    });
  }
}
