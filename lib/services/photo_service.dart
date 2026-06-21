import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Handles camera capture and photo file management
class PhotoService {
  static final ImagePicker _picker = ImagePicker();

  /// Take a photo from camera and save it permanently
  /// Returns the saved file path, or null if cancelled
  static Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80, // Compress to save storage
      maxWidth: 1920,
      maxHeight: 1920,
    );

    if (photo == null) return null;
    return _savePermanently(photo);
  }

  /// Pick a photo from gallery and save it permanently
  static Future<String?> pickFromGallery() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1920,
      maxHeight: 1920,
    );

    if (photo == null) return null;
    return _savePermanently(photo);
  }

  /// Copy the picked/captured image to app's permanent storage
  /// (image_picker gives a temp file that can be deleted by OS)
  static Future<String> _savePermanently(XFile pickedFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final showcaseDir = Directory(p.join(appDir.path, 'showcase'));

    if (!await showcaseDir.exists()) {
      await showcaseDir.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = p.extension(pickedFile.path);
    final fileName = 'photo_$timestamp$extension';
    final savedFile = await File(pickedFile.path).copy(
      p.join(showcaseDir.path, fileName),
    );

    return savedFile.path;
  }

  /// Delete a photo file from storage
  static Future<void> deletePhotoFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
