// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showcase_dao.dart';

// ignore_for_file: type=lint
mixin _$ShowcaseDaoMixin on DatabaseAccessor<AppDatabase> {
  $ShowcasePhotosTable get showcasePhotos => attachedDatabase.showcasePhotos;
  ShowcaseDaoManager get managers => ShowcaseDaoManager(this);
}

class ShowcaseDaoManager {
  final _$ShowcaseDaoMixin _db;
  ShowcaseDaoManager(this._db);
  $$ShowcasePhotosTableTableManager get showcasePhotos =>
      $$ShowcasePhotosTableTableManager(
        _db.attachedDatabase,
        _db.showcasePhotos,
      );
}
