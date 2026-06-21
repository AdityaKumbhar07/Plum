// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_dao.dart';

// ignore_for_file: type=lint
mixin _$QuotationDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomersTable get customers => attachedDatabase.customers;
  $QuotationsTable get quotations => attachedDatabase.quotations;
  $QuotationItemsTable get quotationItems => attachedDatabase.quotationItems;
  QuotationDaoManager get managers => QuotationDaoManager(this);
}

class QuotationDaoManager {
  final _$QuotationDaoMixin _db;
  QuotationDaoManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db.attachedDatabase, _db.customers);
  $$QuotationsTableTableManager get quotations =>
      $$QuotationsTableTableManager(_db.attachedDatabase, _db.quotations);
  $$QuotationItemsTableTableManager get quotationItems =>
      $$QuotationItemsTableTableManager(
        _db.attachedDatabase,
        _db.quotationItems,
      );
}
