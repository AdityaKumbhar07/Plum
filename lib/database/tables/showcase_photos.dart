import 'package:drift/drift.dart';

/// Work showcase photos — stored as file paths, tagged by category
class ShowcasePhotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get filePath => text()();
  TextColumn get category => text()(); // 'plumbing' or 'core_cutting'
  IntColumn get createdAt => integer().withDefault(Constant(DateTime.now().millisecondsSinceEpoch))();
}
