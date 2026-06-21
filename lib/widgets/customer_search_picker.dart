import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../database/database.dart';
import '../database/daos/customer_dao.dart';
import '../theme/app_theme.dart';

/// Reusable customer search + pick widget — used in bill and quotation creation
class CustomerSearchPicker extends StatefulWidget {
  final AppDatabase database;
  final void Function(Customer customer) onCustomerSelected;

  const CustomerSearchPicker({
    super.key,
    required this.database,
    required this.onCustomerSelected,
  });

  @override
  State<CustomerSearchPicker> createState() => _CustomerSearchPickerState();
}

class _CustomerSearchPickerState extends State<CustomerSearchPicker> {
  final _searchController = TextEditingController();
  late final CustomerDao _customerDao;
  List<Customer> _customers = [];
  List<Customer> _recentCustomers = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _customerDao = widget.database.customerDao;
    _loadRecentCustomers();
  }

  Future<void> _loadRecentCustomers() async {
    final recent = await _customerDao.getRecentCustomers();
    if (mounted) setState(() => _recentCustomers = recent);
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _customers = [];
      });
      return;
    }

    setState(() => _isSearching = true);
    _customerDao.searchCustomers(query).first.then((results) {
      if (mounted) setState(() => _customers = results);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.searchCustomers,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),

        // Results
        Expanded(
          child: _isSearching
              ? _buildSearchResults()
              : _buildRecentCustomers(l10n),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_customers.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noCustomersFound,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: _customers.length,
      itemBuilder: (context, index) => _buildCustomerTile(_customers[index]),
    );
  }

  Widget _buildRecentCustomers(AppLocalizations l10n) {
    if (_recentCustomers.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            l10n.recentCustomers,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: PlumColors.textSecondary,
                ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: _recentCustomers.length,
            itemBuilder: (context, index) =>
                _buildCustomerTile(_recentCustomers[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerTile(Customer customer) {
    final initials = customer.name.isNotEmpty
        ? customer.name[0].toUpperCase()
        : '?';

    return ListTile(
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
      title: Text(customer.name),
      subtitle: Text(customer.phone),
      onTap: () => widget.onCustomerSelected(customer),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
