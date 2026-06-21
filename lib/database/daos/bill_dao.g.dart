// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_dao.dart';

// ignore_for_file: type=lint
mixin _$BillDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomersTable get customers => attachedDatabase.customers;
  $BillsTable get bills => attachedDatabase.bills;
  $BillItemsTable get billItems => attachedDatabase.billItems;
  BillDaoManager get managers => BillDaoManager(this);
}

class BillDaoManager {
  final _$BillDaoMixin _db;
  BillDaoManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db.attachedDatabase, _db.customers);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db.attachedDatabase, _db.bills);
  $$BillItemsTableTableManager get billItems =>
      $$BillItemsTableTableManager(_db.attachedDatabase, _db.billItems);
}
