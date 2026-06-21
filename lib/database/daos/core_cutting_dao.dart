import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/core_cutting_rates.dart';

part 'core_cutting_dao.g.dart';

/// All database queries for core cutting rate card
@DriftAccessor(tables: [CoreCuttingRates])
class CoreCuttingDao extends DatabaseAccessor<AppDatabase> with _$CoreCuttingDaoMixin {
  CoreCuttingDao(super.db);

  /// Get all rates ordered by sort order
  Future<List<CoreCuttingRate>> getAllRates() =>
      (select(coreCuttingRates)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();

  /// Watch all rates
  Stream<List<CoreCuttingRate>> watchAllRates() =>
      (select(coreCuttingRates)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).watch();

  /// Add a new rate
  Future<int> addRate(CoreCuttingRatesCompanion rate) =>
      into(coreCuttingRates).insert(rate);

  /// Update a rate
  Future<bool> updateRate(CoreCuttingRate rate) =>
      update(coreCuttingRates).replace(rate);

  /// Delete a rate
  Future<int> deleteRate(int id) =>
      (delete(coreCuttingRates)..where((r) => r.id.equals(id))).go();
}
