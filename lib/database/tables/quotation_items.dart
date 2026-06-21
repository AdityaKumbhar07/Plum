import 'package:drift/drift.dart';
import 'quotations.dart';

/// Items in a quotation — material name + quantity (no prices)
class QuotationItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quotationId => integer().references(Quotations, #id)();
  TextColumn get itemName => text()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  TextColumn get unit => text().withDefault(const Constant(''))();
}
