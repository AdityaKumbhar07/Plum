import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/database.dart';
import '../../services/share_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/customer_search_picker.dart';

/// Create Quotation — pick customer → add material items → send as WhatsApp text
class CreateQuotationScreen extends StatefulWidget {
  final int? preselectedCustomerId;
  final String? preselectedCustomerName;

  const CreateQuotationScreen({
    super.key,
    this.preselectedCustomerId,
    this.preselectedCustomerName,
  });

  @override
  State<CreateQuotationScreen> createState() => _CreateQuotationScreenState();
}

class _QuotationItem {
  final nameController = TextEditingController();
  final qtyController = TextEditingController(text: '1');
  final unitController = TextEditingController();

  void dispose() {
    nameController.dispose();
    qtyController.dispose();
    unitController.dispose();
  }
}

class _CreateQuotationScreenState extends State<CreateQuotationScreen> {
  int? _customerId;
  String? _customerName;
  String? _customerPhone;
  int _step = 0;
  final List<_QuotationItem> _items = [_QuotationItem()];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedCustomerId != null) {
      _customerId = widget.preselectedCustomerId;
      _customerName = widget.preselectedCustomerName;
      _step = 1;
      _loadCustomerPhone();
    }
  }

  Future<void> _loadCustomerPhone() async {
    if (_customerId == null) return;
    final db = context.read<AppDatabase>();
    final customer = await db.customerDao.getCustomerById(_customerId!);
    if (mounted) setState(() => _customerPhone = customer.phone);
  }

  @override
  void dispose() {
    for (final item in _items) {
      item.dispose();
    }
    super.dispose();
  }

  Future<void> _sendQuotation() async {
    setState(() => _saving = true);
    final db = context.read<AppDatabase>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    final navigator = Navigator.of(context);

    try {
      final settings = await db.settingsDao.getSettings();

      // Save to database
      final items = _items
          .where((item) => item.nameController.text.trim().isNotEmpty)
          .map((item) => QuotationItemsCompanion(
                itemName: drift.Value(item.nameController.text.trim()),
                quantity: drift.Value(double.tryParse(item.qtyController.text) ?? 1),
                unit: drift.Value(item.unitController.text.trim()),
              ))
          .toList();

      if (items.isEmpty) {
        if (mounted) setState(() => _saving = false);
        return;
      }

      await db.quotationDao.createQuotation(
        customerId: _customerId!,
        items: items,
      );

      // Format WhatsApp text
      final formattedItems = items.map((i) => {
            'name': (i.itemName as drift.Value).value,
            'quantity': (i.quantity as drift.Value).value,
            'unit': (i.unit as drift.Value).value,
          }).toList();

      final message = ShareService.formatQuotationText(
        customerName: _customerName!,
        items: formattedItems,
        ownerName: settings.ownerName.isNotEmpty ? settings.ownerName : 'Plumber',
        ownerPhone: settings.ownerPhone,
      );

      // Send on WhatsApp
      if (_customerPhone != null) {
        final sent = await ShareService.sendWhatsAppMessage(
          phone: _customerPhone!,
          message: message,
        );

        if (mounted) {
          if (!sent) {
            messenger.showSnackBar(
              SnackBar(content: Text(l10n.whatsappNotInstalled)),
            );
          }
          navigator.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newQuotation),
      ),
      body: _step == 0
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: CustomerSearchPicker(
                database: db,
                onCustomerSelected: (customer) {
                  setState(() {
                    _customerId = customer.id;
                    _customerName = customer.name;
                    _customerPhone = customer.phone;
                    _step = 1;
                  });
                },
              ),
            )
          : _buildItemsEditor(l10n),
      bottomNavigationBar: _step == 1
          ? Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: PlumColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _saving ? null : _sendQuotation,
                    icon: const Icon(Icons.send),
                    label: Text(l10n.sendOnWhatsApp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildItemsEditor(AppLocalizations l10n) {
    return Column(
      children: [
        // Customer banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: PlumColors.quotationColor.withValues(alpha: 0.08),
          child: Row(
            children: [
              const Icon(Icons.person, size: 18, color: PlumColors.quotationColor),
              const SizedBox(width: 8),
              Text(
                _customerName ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: PlumColors.quotationColor,
                ),
              ),
            ],
          ),
        ),

        // Items list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(l10n.materialsList,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              ...List.generate(_items.length, (index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      // Item name
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: item.nameController,
                          decoration: InputDecoration(
                            hintText: '${l10n.itemName} ${index + 1}',
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Quantity
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: item.qtyController,
                          decoration: InputDecoration(
                            hintText: l10n.qty,
                            isDense: true,
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Unit
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: item.unitController,
                          decoration: InputDecoration(
                            hintText: l10n.unit,
                            isDense: true,
                          ),
                        ),
                      ),
                      // Remove
                      if (_items.length > 1)
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _items[index].dispose();
                            setState(() => _items.removeAt(index));
                          },
                          color: PlumColors.error,
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                );
              }),

              // Add more button
              TextButton.icon(
                onPressed: () => setState(() => _items.add(_QuotationItem())),
                icon: const Icon(Icons.add),
                label: Text(l10n.addItem),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
