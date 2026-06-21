import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/database.dart';
import '../../providers/cart_provider.dart';
import '../../services/pdf_service.dart';
import '../../services/share_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/customer_search_picker.dart';

/// Create Bill screen — pick customer → tap items → review → share PDF
class CreateBillScreen extends StatefulWidget {
  final int? preselectedCustomerId;
  final String? preselectedCustomerName;

  const CreateBillScreen({
    super.key,
    this.preselectedCustomerId,
    this.preselectedCustomerName,
  });

  @override
  State<CreateBillScreen> createState() => _CreateBillScreenState();
}

class _CreateBillScreenState extends State<CreateBillScreen> {
  final _cart = CartProvider();
  int _step = 0; // 0 = pick customer, 1 = pick items, 2 = review
  bool _isPaid = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.preselectedCustomerId != null) {
      _cart.selectCustomer(widget.preselectedCustomerId!, widget.preselectedCustomerName!);
      _step = 1;
    }
    _cart.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  Future<void> _generateBill() async {
    setState(() => _saving = true);
    final db = context.read<AppDatabase>();
    final l10n = AppLocalizations.of(context)!;

    try {
      // Save to database
      final billItems = _cart.items
          .map((item) => BillItemsCompanion(
                itemName: drift.Value(item.name),
                quantity: drift.Value(item.quantity),
                unitPrice: drift.Value(item.unitPrice),
                total: drift.Value(item.total),
              ))
          .toList();

      final billId = await db.billDao.createBill(
        customerId: _cart.selectedCustomerId!,
        totalAmount: _cart.grandTotal,
        isPaid: _isPaid,
        items: billItems,
      );

      // Get full bill data for PDF
      final billData = await db.billDao.getBillWithItems(billId);
      final settings = await db.settingsDao.getSettings();

      // Generate PDF
      final pdfFile = await PdfService.generateBillPdf(
        billData: billData,
        ownerName: settings.ownerName.isNotEmpty ? settings.ownerName : 'Plumber',
        ownerPhone: settings.ownerPhone,
      );

      if (mounted) {
        // Show success and share options
        showModalBottomSheet(
          context: context,
          builder: (ctx) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: PlumColors.success, size: 56),
                const SizedBox(height: 12),
                Text('${l10n.billNumber} ${billData.bill.billNumber}',
                    style: Theme.of(ctx).textTheme.titleLarge),
                Text('₹${_cart.grandTotal.toStringAsFixed(0)}',
                    style: Theme.of(ctx).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ShareService.sharePdfFile(pdfFile);
                    },
                    icon: const Icon(Icons.share),
                    label: Text(l10n.shareOnWhatsApp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                  child: Text(l10n.done),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
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
        title: Text(l10n.newBill),
        actions: [
          if (_step > 0)
            TextButton(
              onPressed: _step == 1 && _cart.hasItems
                  ? () => setState(() => _step = 2)
                  : null,
              child: Text(_step == 1 ? l10n.done : ''),
            ),
        ],
      ),
      body: _step == 0
          ? _buildCustomerPicker(db, l10n)
          : _step == 1
              ? _buildItemPicker(db, l10n)
              : _buildReview(l10n),

      // Sticky total bar at bottom
      bottomNavigationBar: _step >= 1 && _cart.hasItems
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
                child: Row(
                  children: [
                    // Total
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.total,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          '₹${_cart.grandTotal.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: PlumColors.primary,
                              ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Action button
                    ElevatedButton(
                      onPressed: _step == 1
                          ? () => setState(() => _step = 2)
                          : _saving
                              ? null
                              : _generateBill,
                      child: Text(
                        _step == 1 ? l10n.done : l10n.generateBill,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  /// Step 0: Pick customer
  Widget _buildCustomerPicker(AppDatabase db, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomerSearchPicker(
        database: db,
        onCustomerSelected: (customer) {
          _cart.selectCustomer(customer.id, customer.name);
          setState(() => _step = 1);
        },
      ),
    );
  }

  /// Step 1: Pick items from saved list (cart-style)
  Widget _buildItemPicker(AppDatabase db, AppLocalizations l10n) {
    return Column(
      children: [
        // Selected customer banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: PlumColors.primary.withValues(alpha: 0.08),
          child: Row(
            children: [
              const Icon(Icons.person, size: 18, color: PlumColors.primary),
              const SizedBox(width: 8),
              Text(
                _cart.selectedCustomerName ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: PlumColors.primary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() => _step = 0),
                child: Text(l10n.edit, style: const TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),

        // Cart items (if any)
        if (_cart.hasItems) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cart.items.length,
            itemBuilder: (context, index) {
              final item = _cart.items[index];
              return ListTile(
                dense: true,
                title: Text(item.name,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('${item.quantity.toStringAsFixed(0)} × ₹${item.unitPrice.toStringAsFixed(0)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹${item.total.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _cart.removeItem(index),
                      child: const Icon(Icons.close, size: 18, color: PlumColors.error),
                    ),
                  ],
                ),
                onTap: () => _showEditItemDialog(index, item),
              );
            },
          ),
          const Divider(),
        ],

        // Saved items grid — tap to add
        Expanded(
          child: StreamBuilder<List<SavedItem>>(
            stream: db.savedItemDao.watchAllItems(),
            builder: (context, snapshot) {
              final savedItems = snapshot.data ?? [];
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(l10n.savedCharges,
                            style: Theme.of(context).textTheme.titleSmall),
                        const Spacer(),
                        // Add custom item
                        TextButton.icon(
                          onPressed: _showAddCustomItemDialog,
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(l10n.customItem, style: const TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 2.8,
                        ),
                        itemCount: savedItems.length,
                        itemBuilder: (context, index) {
                          final item = savedItems[index];
                          return Material(
                            color: PlumColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () =>
                                  _cart.addSavedItem(item.name, item.defaultPrice),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '₹${item.defaultPrice.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: PlumColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Step 2: Review and confirm
  Widget _buildReview(AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Customer
        Card(
          child: ListTile(
            leading: const Icon(Icons.person, color: PlumColors.primary),
            title: Text(_cart.selectedCustomerName ?? ''),
            subtitle: Text(l10n.customer),
          ),
        ),
        const SizedBox(height: 12),

        // Items
        Text(l10n.billItems, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...List.generate(_cart.items.length, (index) {
          final item = _cart.items[index];
          return Card(
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(
                '${item.quantity.toStringAsFixed(0)} × ₹${item.unitPrice.toStringAsFixed(0)}',
              ),
              trailing: Text(
                '₹${item.total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }),

        const SizedBox(height: 16),

        // Mark as paid toggle
        Card(
          child: SwitchListTile(
            title: Text(l10n.markAsPaid),
            subtitle: Text(_isPaid ? l10n.paid : l10n.unpaid),
            value: _isPaid,
            onChanged: (v) => setState(() => _isPaid = v),
            activeColor: PlumColors.success,
          ),
        ),
      ],
    );
  }

  void _showEditItemDialog(int index, CartItem item) {
    final qtyController = TextEditingController(text: item.quantity.toStringAsFixed(0));
    final priceController = TextEditingController(text: item.unitPrice.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: qtyController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.quantity),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.price),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final qty = double.tryParse(qtyController.text) ?? item.quantity;
              final price = double.tryParse(priceController.text) ?? item.unitPrice;
              _cart.updateQuantity(index, qty);
              _cart.updatePrice(index, price);
              Navigator.pop(ctx);
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  void _showAddCustomItemDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.customItem),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.itemName),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.price),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final price = double.tryParse(priceController.text) ?? 0;
              if (name.isNotEmpty && price > 0) {
                _cart.addItem(CartItem(name: name, unitPrice: price));
                Navigator.pop(ctx);
              }
            },
            child: Text(AppLocalizations.of(context)!.addItem),
          ),
        ],
      ),
    );
  }
}
