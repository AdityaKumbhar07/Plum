import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

/// Manage saved charges — add, edit, delete, reorder
class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.savedCharges),
      ),
      body: StreamBuilder<List<SavedItem>>(
        stream: db.savedItemDao.watchAllItems(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.list_alt,
              title: l10n.noSavedItems,
              subtitle: l10n.addFirstItem,
              onAction: () => _showAddDialog(context, db),
              actionLabel: l10n.addItem,
            );
          }

          return ReorderableListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: items.length,
            onReorder: (oldIndex, newIndex) async {
              if (newIndex > oldIndex) newIndex--;
              final reordered = List<SavedItem>.from(items);
              final moved = reordered.removeAt(oldIndex);
              reordered.insert(newIndex, moved);
              await db.savedItemDao.reorderItems(reordered);
            },
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: ValueKey(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: PlumColors.error,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => db.savedItemDao.deleteItem(item.id),
                child: Card(
                  key: ValueKey(item.id),
                  child: ListTile(
                    leading: const Icon(Icons.drag_handle, color: PlumColors.textHint),
                    title: Text(item.name,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    trailing: Text(
                      '₹${item.defaultPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: PlumColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => _showEditDialog(context, db, item),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, db),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, AppDatabase db) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.addItem),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.itemName),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: l10n.defaultPrice),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(ctx);
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;
              if (name.isNotEmpty && price > 0) {
                await db.savedItemDao.addItem(
                  SavedItemsCompanion.insert(
                    name: name,
                    defaultPrice: price,
                  ),
                );
                navigator.pop();
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, AppDatabase db, SavedItem item) {
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.defaultPrice.toStringAsFixed(0));
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.edit),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.itemName),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: l10n.defaultPrice),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(ctx);
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;
              if (name.isNotEmpty && price > 0) {
                await db.savedItemDao.updateItem(
                  SavedItem(
                    id: item.id,
                    name: name,
                    defaultPrice: price,
                    sortOrder: item.sortOrder,
                  ),
                );
                navigator.pop();
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
