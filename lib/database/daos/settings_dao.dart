import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/app_settings.dart';

part 'settings_dao.g.dart';

/// All database queries for app settings (plumber profile + preferences)
@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  /// Get settings (always row id=1)
  Future<AppSetting> getSettings() =>
      (select(appSettings)..where((s) => s.id.equals(1))).getSingle();

  /// Watch settings for reactive updates
  Stream<AppSetting> watchSettings() =>
      (select(appSettings)..where((s) => s.id.equals(1))).watchSingle();

  /// Update plumber's profile
  Future<void> updateProfile({required String name, required String phone}) async {
    await (update(appSettings)..where((s) => s.id.equals(1))).write(
      AppSettingsCompanion(
        ownerName: Value(name),
        ownerPhone: Value(phone),
      ),
    );
  }

  /// Update locale preference
  Future<void> updateLocale(String locale) async {
    await (update(appSettings)..where((s) => s.id.equals(1))).write(
      AppSettingsCompanion(locale: Value(locale)),
    );
  }

  /// Check if profile is set up (first launch detection)
  Future<bool> isProfileSetUp() async {
    final settings = await getSettings();
    return settings.ownerName.isNotEmpty && settings.ownerPhone.isNotEmpty;
  }
}
