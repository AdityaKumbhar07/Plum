import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../theme/app_theme.dart';

/// Manage core cutting rate card — edit prices per hole size, add/delete sizes
class CoreCuttingRatesScreen extends StatelessWidget {
  const CoreCuttingRatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.coreCuttingRates),
      ),
      body: StreamBuilder<List<CoreCuttingRate>>(
        stream: db.coreCuttingDao.watchAllRates(),
        builder: (context, snapshot) {
          final rates = snapshot.data ?? [];

          if (rates.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: rates.length,
            itemBuilder: (context, index) {
              final rate = rates[index];
              return Dismissible(
                key: ValueKey(rate.id),
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
                onDismissed: (_) => db.coreCuttingDao.deleteRate(rate.id),
                child: Card(
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: PlumColors.calculatorColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          rate.holeSize,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: PlumColors.calculatorColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    title: Text('${l10n.holeSize}: ${rate.holeSize}'),
                    trailing: Text(
                      '₹${rate.pricePerHole.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: PlumColors.primary,
                        fontSize: 18,
                      ),
                    ),
                    onTap: () => _showEditDialog(context, db, rate),
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
    final sizeController = TextEditingController();
    final priceController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.addSize),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: sizeController,
              decoration: InputDecoration(
                labelText: l10n.holeSize,
                hintText: '4"',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: l10n.pricePerHole),
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
              final size = sizeController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;
              if (size.isNotEmpty && price > 0) {
                await db.coreCuttingDao.addRate(
                  CoreCuttingRatesCompanion.insert(
                    holeSize: size,
                    pricePerHole: price,
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

  void _showEditDialog(BuildContext context, AppDatabase db, CoreCuttingRate rate) {
    final priceController = TextEditingController(text: rate.pricePerHole.toStringAsFixed(0));
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${l10n.holeSize}: ${rate.holeSize}'),
        content: TextField(
          controller: priceController,
          decoration: InputDecoration(labelText: l10n.pricePerHole),
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(ctx);
              final price = double.tryParse(priceController.text) ?? 0;
              if (price > 0) {
                await db.coreCuttingDao.updateRate(
                  CoreCuttingRate(
                    id: rate.id,
                    holeSize: rate.holeSize,
                    pricePerHole: price,
                    sortOrder: rate.sortOrder,
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
