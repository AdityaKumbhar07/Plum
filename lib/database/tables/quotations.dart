import 'package:drift/drift.dart';
import 'customers.dart';

/// A quotation is a material shopping list sent to customer (no prices)
class Quotations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get createdAt => integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
}
