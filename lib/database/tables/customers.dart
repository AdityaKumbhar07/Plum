import 'package:drift/drift.dart';

/// Stores customer info — name + phone required, address optional
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get phone => text().withLength(min: 1, max: 20)();
  TextColumn get address => text().withDefault(const Constant(''))();
  IntColumn get createdAt => integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
}
