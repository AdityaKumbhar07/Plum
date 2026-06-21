import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../database/database.dart';
import '../../providers/locale_provider.dart';
import '../../theme/app_theme.dart';
import 'saved_items_screen.dart';
import 'core_cutting_rates_screen.dart';

/// Settings screen — profile, language toggle, saved items, rate card
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    if (!mounted) return;
    final db = context.read<AppDatabase>();
    final settings = await db.settingsDao.getSettings();
    if (!mounted) return;

    _nameController.text = settings.ownerName;
    _phoneController.text = settings.ownerPhone;

    // Sync locale provider with saved preference
    final localeProvider = context.read<LocaleProvider>();
    if (settings.locale == 'mr' && !localeProvider.isMarathi) {
      localeProvider.setLocale(const Locale('mr'));
    } else if (settings.locale == 'en' && localeProvider.isMarathi) {
      localeProvider.setLocale(const Locale('en'));
    }

    setState(() => _loaded = true);
  }

  Future<void> _saveProfile() async {
    final db = context.read<AppDatabase>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;

    await db.settingsDao.updateProfile(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.success),
        backgroundColor: PlumColors.success,
      ),
    );
  }

  Future<void> _toggleLanguage() async {
    final localeProvider = context.read<LocaleProvider>();
    final db = context.read<AppDatabase>();

    localeProvider.toggleLocale();
    await db.settingsDao.updateLocale(localeProvider.locale.languageCode);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = context.watch<LocaleProvider>();

    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile section
          Text(l10n.profile, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: l10n.ownerName,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: l10n.ownerPhone,
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      child: Text(l10n.save),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Language toggle
          Text(l10n.language, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              title: Text(localeProvider.isMarathi ? l10n.marathi : l10n.english),
              subtitle: Text(
                localeProvider.isMarathi
                    ? 'Switch to English'
                    : 'मराठी मध्ये बदला',
              ),
              value: localeProvider.isMarathi,
              onChanged: (_) => _toggleLanguage(),
              activeColor: PlumColors.primary,
              secondary: const Icon(Icons.language),
            ),
          ),

          const SizedBox(height: 24),

          // Navigation tiles
          Text(l10n.savedItems, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.list, color: PlumColors.primary),
              title: Text(l10n.savedCharges),
              subtitle: Text(l10n.addFirstItem),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedItemsScreen()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.calculate, color: PlumColors.calculatorColor),
              title: Text(l10n.coreCuttingRates),
              subtitle: Text(l10n.rateCard),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CoreCuttingRatesScreen()),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // About
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline, color: PlumColors.textHint),
              title: Text(l10n.about),
              subtitle: Text('${l10n.version} 1.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
