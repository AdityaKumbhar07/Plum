import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../database/database.dart';
import '../../theme/app_theme.dart';
import '../bills/create_bill_screen.dart';
import '../quotations/create_quotation_screen.dart';

/// Customer detail — shows info, past bills, past quotations, and pending balance
class CustomerDetailScreen extends StatefulWidget {
  final int customerId;

  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Customer? _customer;
  double _pendingBalance = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadCustomer();
  }

  Future<void> _loadCustomer() async {
    final db = context.read<AppDatabase>();
    final customer = await db.customerDao.getCustomerById(widget.customerId);
    final balance = await db.billDao.getPendingBalanceForCustomer(widget.customerId);
    if (mounted) {
      setState(() {
        _customer = customer;
        _pendingBalance = balance;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    if (_customer == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_customer!.name),
        actions: [
          // Quick bill button
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: l10n.newBill,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateBillScreen(
                  preselectedCustomerId: _customer!.id,
                  preselectedCustomerName: _customer!.name,
                ),
              ),
            ).then((_) => _loadCustomer()),
          ),
          // Quick quotation button
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: l10n.newQuotation,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateQuotationScreen(
                  preselectedCustomerId: _customer!.id,
                  preselectedCustomerName: _customer!.name,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Customer info card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PlumColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: PlumColors.cardBorder),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: PlumColors.primary.withValues(alpha: 0.15),
                      child: Text(
                        _customer!.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: PlumColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _customer!.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 16, color: PlumColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(_customer!.phone,
                                  style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          if (_customer!.address.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: PlumColors.textSecondary),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(_customer!.address,
                                      style: Theme.of(context).textTheme.bodyMedium),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                // Pending balance banner
                if (_pendingBalance > 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: PlumColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber, color: PlumColors.error, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${l10n.balanceDue}: ₹${_pendingBalance.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: PlumColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Tab bar — Bills | Quotations
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.bills),
              Tab(text: l10n.quotations),
            ],
            labelColor: PlumColors.primary,
            unselectedLabelColor: PlumColors.textHint,
            indicatorColor: PlumColors.primary,
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Bills tab
                StreamBuilder<List<Bill>>(
                  stream: db.billDao.watchBillsForCustomer(widget.customerId),
                  builder: (context, snapshot) {
                    final bills = snapshot.data ?? [];
                    if (bills.isEmpty) {
                      return Center(
                        child: Text(l10n.noBills,
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: bills.length,
                      itemBuilder: (context, index) {
                        final bill = bills[index];
                        final date = DateFormat('dd MMM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(bill.createdAt),
                        );
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: bill.isPaid
                                  ? PlumColors.success.withValues(alpha: 0.15)
                                  : PlumColors.error.withValues(alpha: 0.15),
                              child: Icon(
                                bill.isPaid ? Icons.check_circle : Icons.pending,
                                color: bill.isPaid ? PlumColors.success : PlumColors.error,
                                size: 20,
                              ),
                            ),
                            title: Text('${l10n.billNumber} ${bill.billNumber}'),
                            subtitle: Text(date),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${bill.totalAmount.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  bill.isPaid ? l10n.paid : l10n.unpaid,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: bill.isPaid ? PlumColors.success : PlumColors.error,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                // Quotations tab
                StreamBuilder<List<Quotation>>(
                  stream: db.quotationDao.watchQuotationsForCustomer(widget.customerId),
                  builder: (context, snapshot) {
                    final quotations = snapshot.data ?? [];
                    if (quotations.isEmpty) {
                      return Center(
                        child: Text(l10n.noQuotations,
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: quotations.length,
                      itemBuilder: (context, index) {
                        final quotation = quotations[index];
                        final date = DateFormat('dd MMM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(quotation.createdAt),
                        );
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: PlumColors.quotationColor.withValues(alpha: 0.15),
                              child: const Icon(Icons.list_alt,
                                  color: PlumColors.quotationColor, size: 20),
                            ),
                            title: Text('${l10n.quotation} #${quotation.id}'),
                            subtitle: Text(date),
                            trailing: const Icon(Icons.chevron_right,
                                color: PlumColors.textHint),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
