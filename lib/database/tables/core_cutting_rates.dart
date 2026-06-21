import 'package:drift/drift.dart';

/// Core cutting rate card — price per hole for each hole size
class CoreCuttingRates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get holeSize => text()(); // e.g. '2"', '4"', '6"'
  RealColumn get pricePerHole => real()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}
