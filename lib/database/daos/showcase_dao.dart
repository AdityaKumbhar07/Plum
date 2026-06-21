import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/showcase_photos.dart';

part 'showcase_dao.g.dart';

/// All database queries for work showcase photos
@DriftAccessor(tables: [ShowcasePhotos])
class ShowcaseDao extends DatabaseAccessor<AppDatabase> with _$ShowcaseDaoMixin {
  ShowcaseDao(super.db);

  /// Get all photos, optionally filtered by category
  Stream<List<ShowcasePhoto>> watchPhotos({String? category}) {
    if (category != null && category.isNotEmpty) {
      return (select(showcasePhotos)
            ..where((p) => p.category.equals(category))
            ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
          .watch();
    }
    return (select(showcasePhotos)
          ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]))
        .watch();
  }

  /// Add a new photo
  Future<int> addPhoto(ShowcasePhotosCompanion photo) =>
      into(showcasePhotos).insert(photo);

  /// Delete a photo
  Future<int> deletePhoto(int id) =>
      (delete(showcasePhotos)..where((p) => p.id.equals(id))).go();

  /// Get photo count
  Future<int> getPhotoCount() async {
    final result = await customSelect(
      'SELECT COUNT(*) AS count FROM showcase_photos',
      readsFrom: {showcasePhotos},
    ).getSingle();
    return result.read<int>('count');
  }
}
