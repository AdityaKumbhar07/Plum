import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../database/daos/bill_dao.dart';
import '../../services/share_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

/// Payment tracker — all customers with pending balance, one-tap mark paid, WhatsApp reminder
class PaymentTrackerScreen extends StatefulWidget {
  const PaymentTrackerScreen({super.key});

  @override
  State<PaymentTrackerScreen> createState() => _PaymentTrackerScreenState();
}

class _PaymentTrackerScreenState extends State<PaymentTrackerScreen> {
  List<CustomerWithBalance> _customers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPendingPayments();
  }

  Future<void> _loadPendingPayments() async {
    setState(() => _loading = true);
    final db = context.read<AppDatabase>();
    final customers = await db.billDao.getCustomersWithPendingBalance();
    if (mounted) {
      setState(() {
        _customers = customers;
        _loading = false;
      });
    }
  }

  Future<void> _markAllPaid(CustomerWithBalance cwb) async {
    final db = context.read<AppDatabase>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    await db.billDao.markAllBillsPaidForCustomer(cwb.customer.id);
    _loadPendingPayments();

    if (mounted) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('${cwb.customer.name} — ${l10n.paid}'),
          backgroundColor: PlumColors.success,
        ),
      );
    }
  }

  Future<void> _sendReminder(CustomerWithBalance cwb) async {
    final db = context.read<AppDatabase>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    final settings = await db.settingsDao.getSettings();

    final message = ShareService.formatReminderMessage(
      customerName: cwb.customer.name,
      amount: cwb.totalDue,
      ownerName: settings.ownerName.isNotEmpty ? settings.ownerName : 'Plumber',
    );

    final sent = await ShareService.sendWhatsAppMessage(
      phone: cwb.customer.phone,
      message: message,
    );

    if (!sent && mounted) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.whatsappNotInstalled),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pendingPayments),
      ),
      body: RefreshIndicator(
        onRefresh: _loadPendingPayments,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _customers.isEmpty
                ? EmptyState(
                    icon: Icons.check_circle_outline,
                    title: l10n.noPendingPayments,
                    subtitle: l10n.allPaymentsCleared,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _customers.length,
                    itemBuilder: (context, index) {
                      final cwb = _customers[index];
                      return Dismissible(
                        key: ValueKey(cwb.customer.id),
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 24),
                          decoration: BoxDecoration(
                            color: PlumColors.success,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 28),
                        ),
                        onDismissed: (_) => _markAllPaid(cwb),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: PlumColors.error.withValues(alpha: 0.15),
                              child: Text(
                                cwb.customer.name[0].toUpperCase(),
                                style: const TextStyle(
                                  color: PlumColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            title: Text(
                              cwb.customer.name,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(cwb.customer.phone),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₹${cwb.totalDue.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: PlumColors.error,
                                      ),
                                    ),
                                    Text(
                                      l10n.balanceDue,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: PlumColors.textHint,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                // WhatsApp reminder button
                                IconButton(
                                  onPressed: () => _sendReminder(cwb),
                                  icon: const Icon(
                                    Icons.message,
                                    color: Color(0xFF25D366),
                                  ),
                                  tooltip: l10n.sendReminder,
                                ),
                              ],
                            ),
                            onTap: () => _markAllPaid(cwb),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
