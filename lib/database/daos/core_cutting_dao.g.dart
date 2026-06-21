// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_cutting_dao.dart';

// ignore_for_file: type=lint
mixin _$CoreCuttingDaoMixin on DatabaseAccessor<AppDatabase> {
  $CoreCuttingRatesTable get coreCuttingRates =>
      attachedDatabase.coreCuttingRates;
  CoreCuttingDaoManager get managers => CoreCuttingDaoManager(this);
}

class CoreCuttingDaoManager {
  final _$CoreCuttingDaoMixin _db;
  CoreCuttingDaoManager(this._db);
  $$CoreCuttingRatesTableTableManager get coreCuttingRates =>
      $$CoreCuttingRatesTableTableManager(
        _db.attachedDatabase,
        _db.coreCuttingRates,
      );
}
