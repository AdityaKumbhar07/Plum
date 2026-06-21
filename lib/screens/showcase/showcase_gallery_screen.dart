import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/database.dart';
import '../../services/photo_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/confirm_dialog.dart';

/// Work showcase gallery — fullscreen clean gallery, no customer names (privacy)
class ShowcaseGalleryScreen extends StatefulWidget {
  const ShowcaseGalleryScreen({super.key});

  @override
  State<ShowcaseGalleryScreen> createState() => _ShowcaseGalleryScreenState();
}

class _ShowcaseGalleryScreenState extends State<ShowcaseGalleryScreen> {
  String? _selectedCategory;

  Future<void> _takePhoto() async {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    // Pick category first
    final category = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.pickCategory,
                style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 16),
            _CategoryOption(
              icon: Icons.plumbing,
              label: l10n.plumbing,
              color: PlumColors.primary,
              onTap: () => Navigator.pop(ctx, 'plumbing'),
            ),
            const SizedBox(height: 8),
            _CategoryOption(
              icon: Icons.circle_outlined,
              label: l10n.coreCutting,
              color: PlumColors.calculatorColor,
              onTap: () => Navigator.pop(ctx, 'core_cutting'),
            ),
          ],
        ),
      ),
    );

    if (category == null || !mounted) return;

    // Take photo
    final filePath = await PhotoService.takePhoto();
    if (filePath == null || !mounted) return;

    // Save to database
    await db.showcaseDao.addPhoto(
      ShowcasePhotosCompanion(
        filePath: drift.Value(filePath),
        category: drift.Value(category),
        createdAt: drift.Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> _deletePhoto(ShowcasePhoto photo) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await ConfirmDialog.show(
      context,
      title: l10n.deletePhoto,
      message: l10n.deletePhotoConfirm,
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
    );

    if (confirmed && mounted) {
      final db = context.read<AppDatabase>();
      await PhotoService.deletePhotoFile(photo.filePath);
      await db.showcaseDao.deletePhoto(photo.id);
    }
  }

  void _openFullscreen(List<ShowcasePhoto> photos, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullscreenViewer(photos: photos, initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.showcase),
      ),
      body: Column(
        children: [
          // Filter tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.all,
                  selected: _selectedCategory == null,
                  onTap: () => setState(() => _selectedCategory = null),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.plumbing,
                  selected: _selectedCategory == 'plumbing',
                  onTap: () => setState(() => _selectedCategory = 'plumbing'),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: l10n.coreCutting,
                  selected: _selectedCategory == 'core_cutting',
                  onTap: () => setState(() => _selectedCategory = 'core_cutting'),
                ),
              ],
            ),
          ),

          // Gallery grid
          Expanded(
            child: StreamBuilder<List<ShowcasePhoto>>(
              stream: db.showcaseDao.watchPhotos(category: _selectedCategory),
              builder: (context, snapshot) {
                final photos = snapshot.data ?? [];

                if (photos.isEmpty) {
                  return EmptyState(
                    icon: Icons.photo_library_outlined,
                    title: l10n.noPhotos,
                    subtitle: l10n.addFirstPhoto,
                    onAction: _takePhoto,
                    actionLabel: l10n.takePhoto,
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];
                    return GestureDetector(
                      onTap: () => _openFullscreen(photos, index),
                      onLongPress: () => _deletePhoto(photo),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(photo.filePath),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: PlumColors.surfaceVariant,
                            child: const Icon(Icons.broken_image,
                                color: PlumColors.textHint),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? PlumColors.primary.withValues(alpha: 0.15)
              : PlumColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
          border: selected
              ? Border.all(color: PlumColors.primary.withValues(alpha: 0.3))
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? PlumColors.primary : PlumColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _CategoryOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _CategoryOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fullscreen photo viewer with swipe navigation
class _FullscreenViewer extends StatelessWidget {
  final List<ShowcasePhoto> photos;
  final int initialIndex;

  const _FullscreenViewer({required this.photos, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Center(
              child: Image.file(
                File(photos[index].filePath),
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.broken_image,
                  color: Colors.white54,
                  size: 64,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
