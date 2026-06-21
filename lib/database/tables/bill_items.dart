import 'package:drift/drift.dart';
import 'bills.dart';

/// Line items inside a bill — item name, qty, unit price, line total
class BillItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get billId => integer().references(Bills, #id)();
  TextColumn get itemName => text()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  RealColumn get unitPrice => real()();
  RealColumn get total => real()();
}
