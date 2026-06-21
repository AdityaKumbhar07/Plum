import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'theme/app_theme.dart';
import 'providers/locale_provider.dart';
import 'providers/database_provider.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/customers/customer_list_screen.dart';
import 'screens/payments/payment_tracker_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  final database = await DatabaseProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        Provider.value(value: database),
      ],
      child: const PlumApp(),
    ),
  );
}

class PlumApp extends StatelessWidget {
  const PlumApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      title: 'Plum',
      debugShowCheckedModeBanner: false,
      theme: PlumTheme.lightTheme,
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('mr'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const PlumShell(),
    );
  }
}

/// Main app shell with bottom navigation
class PlumShell extends StatefulWidget {
  const PlumShell({super.key});

  @override
  State<PlumShell> createState() => _PlumShellState();
}

class _PlumShellState extends State<PlumShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    CustomerListScreen(),
    PaymentTrackerScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_outline),
            activeIcon: const Icon(Icons.people),
            label: l10n.customers,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            activeIcon: const Icon(Icons.account_balance_wallet),
            label: l10n.payments,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
