import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../theme/app_theme.dart';
import '../bills/create_bill_screen.dart';

/// Core cutting calculator — pick hole size, enter qty, see instant price, add to bill
class CoreCuttingCalculatorScreen extends StatefulWidget {
  const CoreCuttingCalculatorScreen({super.key});

  @override
  State<CoreCuttingCalculatorScreen> createState() =>
      _CoreCuttingCalculatorScreenState();
}

class _CoreCuttingCalculatorScreenState extends State<CoreCuttingCalculatorScreen> {
  List<CoreCuttingRate> _rates = [];
  CoreCuttingRate? _selectedRate;
  final _qtyController = TextEditingController(text: '1');
  double _calculatedPrice = 0;

  @override
  void initState() {
    super.initState();
    _loadRates();
  }

  Future<void> _loadRates() async {
    final db = context.read<AppDatabase>();
    final rates = await db.coreCuttingDao.getAllRates();
    if (mounted) {
      setState(() {
        _rates = rates;
        if (rates.isNotEmpty) {
          _selectedRate = rates[0];
          _calculate();
        }
      });
    }
  }

  void _calculate() {
    if (_selectedRate == null) return;
    final qty = double.tryParse(_qtyController.text) ?? 0;
    setState(() {
      _calculatedPrice = _selectedRate!.pricePerHole * qty;
    });
  }

  @override
  void dispose() {
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.coreCuttingCalc),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Rate card display
          Text(l10n.rateCard, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),

          // Hole size chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _rates.map((rate) {
              final isSelected = _selectedRate?.id == rate.id;
              return ChoiceChip(
                label: Text(
                  '${rate.holeSize} — ₹${rate.pricePerHole.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? PlumColors.primary : null,
                  ),
                ),
                selected: isSelected,
                onSelected: (_) {
                  setState(() => _selectedRate = rate);
                  _calculate();
                },
                selectedColor: PlumColors.primary.withValues(alpha: 0.15),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),

          // Quantity input
          Text(l10n.numberOfHoles,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _qtyController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '1',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      final current = int.tryParse(_qtyController.text) ?? 1;
                      if (current > 1) {
                        _qtyController.text = '${current - 1}';
                        _calculate();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      final current = int.tryParse(_qtyController.text) ?? 0;
                      _qtyController.text = '${current + 1}';
                      _calculate();
                    },
                  ),
                ],
              ),
            ),
            onChanged: (_) => _calculate(),
          ),

          const SizedBox(height: 32),

          // Calculated price — big and prominent
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  PlumColors.primary.withValues(alpha: 0.1),
                  PlumColors.primaryLight.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: PlumColors.primary.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                Text(
                  l10n.calculatedPrice,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${_calculatedPrice.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: PlumColors.primary,
                      ),
                ),
                if (_selectedRate != null)
                  Text(
                    '${_selectedRate!.holeSize} × ${_qtyController.text} = ₹${_calculatedPrice.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Add to bill button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _selectedRate != null && _calculatedPrice > 0
                  ? () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateBillScreen(),
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.receipt_long),
              label: Text(l10n.addToBill),
            ),
          ),
        ],
      ),
    );
  }
}
