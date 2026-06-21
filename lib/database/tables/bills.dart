import 'package:drift/drift.dart';
import 'customers.dart';

/// Each bill belongs to a customer, has a total and payment status
class Bills extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get customerId => integer().references(Customers, #id)();
  IntColumn get billNumber => integer()();
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();
  RealColumn get amountPaid => real().withDefault(const Constant(0.0))();
  IntColumn get createdAt => integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
}
