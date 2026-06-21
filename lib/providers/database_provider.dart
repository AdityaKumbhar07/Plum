import 'package:plum/database/database.dart';

/// Provides the singleton AppDatabase instance
class DatabaseProvider {
  static AppDatabase? _database;

  static Future<AppDatabase> initialize() async {
    _database ??= AppDatabase();
    return _database!;
  }

  static AppDatabase get instance {
    if (_database == null) {
      throw StateError('Database not initialized. Call initialize() first.');
    }
    return _database!;
  }
}
