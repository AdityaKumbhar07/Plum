import 'package:drift/drift.dart';

/// Single-row settings table — plumber's profile + app preferences
class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ownerName => text()();
  TextColumn get ownerPhone => text()();
  TextColumn get locale => text().withDefault(const Constant('mr'))();
}
