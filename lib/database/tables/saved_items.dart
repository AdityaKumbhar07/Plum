import 'package:drift/drift.dart';

/// Plumber's saved list of common charges — tap to add to bill instantly
class SavedItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  RealColumn get defaultPrice => real()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
