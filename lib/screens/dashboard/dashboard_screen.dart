import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../database/daos/bill_dao.dart';
import '../../theme/app_theme.dart';
import '../bills/create_bill_screen.dart';
import '../quotations/create_quotation_screen.dart';
import '../customers/add_customer_sheet.dart';
import '../calculator/core_cutting_calculator_screen.dart';
import '../showcase/showcase_gallery_screen.dart';
import 'package:intl/intl.dart';

/// Home screen — quick action grid + recent activity
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<BillWithItems> _recentBills = [];

  @override
  void initState() {
    super.initState();
    _loadRecentBills();
  }

  Future<void> _loadRecentBills() async {
    final db = context.read<AppDatabase>();
    final bills = await db.billDao.getRecentBills(limit: 5);
    if (mounted) setState(() => _recentBills = bills);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [PlumColors.primary, PlumColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.plumbing, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Text(l10n.appTitle),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecentBills,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Quick Actions header
            Text(
              l10n.quickActions,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Quick action grid — 6 tiles
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
              children: [
                _QuickActionTile(
                  icon: Icons.receipt_long,
                  label: l10n.newBill,
                  color: PlumColors.billColor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateBillScreen()),
                  ).then((_) => _loadRecentBills()),
                ),
                _QuickActionTile(
                  icon: Icons.list_alt,
                  label: l10n.newQuotation,
                  color: PlumColors.quotationColor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateQuotationScreen()),
                  ),
                ),
                _QuickActionTile(
                  icon: Icons.person_add,
                  label: l10n.addCustomer,
                  color: PlumColors.customerColor,
                  onTap: () => AddCustomerSheet.show(context),
                ),
                _QuickActionTile(
                  icon: Icons.calculate,
                  label: l10n.coreCuttingCalc,
                  color: PlumColors.calculatorColor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CoreCuttingCalculatorScreen()),
                  ),
                ),
                _QuickActionTile(
                  icon: Icons.photo_library,
                  label: l10n.workShowcase,
                  color: PlumColors.showcaseColor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ShowcaseGalleryScreen()),
                  ),
                ),
                _QuickActionTile(
                  icon: Icons.account_balance_wallet,
                  label: l10n.pendingPayments,
                  color: PlumColors.paymentColor,
                  // Switches to payments tab (index 2)
                  onTap: () {
                    // Find the parent PlumShell and switch tab
                    final scaffoldState = Scaffold.maybeOf(context);
                    if (scaffoldState != null) {
                      // Navigate to Payments tab via ancestor state
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Recent activity
            if (_recentBills.isNotEmpty) ...[
              Text(
                l10n.recentActivity,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ...List.generate(_recentBills.length, (index) {
                final billData = _recentBills[index];
                final date = DateFormat('dd MMM').format(
                  DateTime.fromMillisecondsSinceEpoch(billData.bill.createdAt),
                );
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: billData.bill.isPaid
                          ? PlumColors.success.withValues(alpha: 0.15)
                          : PlumColors.error.withValues(alpha: 0.15),
                      child: Icon(
                        billData.bill.isPaid ? Icons.check_circle : Icons.pending,
                        color: billData.bill.isPaid ? PlumColors.success : PlumColors.error,
                        size: 20,
                      ),
                    ),
                    title: Text(billData.customer.name),
                    subtitle: Text(
                      '${l10n.billNumber} ${billData.bill.billNumber} • $date',
                    ),
                    trailing: Text(
                      '₹${billData.bill.totalAmount.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}

/// Single quick-action tile on the dashboard
class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color.withValues(alpha: 0.9),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
