import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import 'customer_detail_screen.dart';
import 'add_customer_sheet.dart';

/// Customer list with instant search — the primary way to find a customer
class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.customers),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.searchCustomers,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Customer list
          Expanded(
            child: StreamBuilder<List<Customer>>(
              stream: _searchQuery.isEmpty
                  ? db.customerDao.watchAllCustomers()
                  : db.customerDao.searchCustomers(_searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final customers = snapshot.data ?? [];

                if (customers.isEmpty) {
                  return EmptyState(
                    icon: Icons.people_outline,
                    title: _searchQuery.isNotEmpty
                        ? l10n.noCustomersFound
                        : l10n.noCustomersFound,
                    subtitle: _searchQuery.isNotEmpty
                        ? ''
                        : l10n.addFirstCustomer,
                    onAction: _searchQuery.isEmpty
                        ? () => AddCustomerSheet.show(context)
                        : null,
                    actionLabel: l10n.addCustomer,
                  );
                }

                return ListView.builder(
                  itemCount: customers.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    final initials = customer.name.isNotEmpty
                        ? customer.name[0].toUpperCase()
                        : '?';

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: PlumColors.primary.withValues(alpha: 0.15),
                          child: Text(
                            initials,
                            style: const TextStyle(
                              color: PlumColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        title: Text(
                          customer.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(customer.phone),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: PlumColors.textHint,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerDetailScreen(
                              customerId: customer.id,
                            ),
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
        onPressed: () => AddCustomerSheet.show(context),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
