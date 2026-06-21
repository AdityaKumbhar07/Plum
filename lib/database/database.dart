import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Table imports
import 'tables/customers.dart';
import 'tables/bills.dart';
import 'tables/bill_items.dart';
import 'tables/quotations.dart';
import 'tables/quotation_items.dart';
import 'tables/saved_items.dart';
import 'tables/showcase_photos.dart';
import 'tables/core_cutting_rates.dart';
import 'tables/app_settings.dart';

// DAO imports
import 'daos/customer_dao.dart';
import 'daos/bill_dao.dart';
import 'daos/quotation_dao.dart';
import 'daos/saved_item_dao.dart';
import 'daos/showcase_dao.dart';
import 'daos/core_cutting_dao.dart';
import 'daos/settings_dao.dart';

part 'database.g.dart';

/// Main Drift database — connects all tables and DAOs
@DriftDatabase(
  tables: [
    Customers,
    Bills,
    BillItems,
    Quotations,
    QuotationItems,
    SavedItems,
    ShowcasePhotos,
    CoreCuttingRates,
    AppSettings,
  ],
  daos: [
    CustomerDao,
    BillDao,
    QuotationDao,
    SavedItemDao,
    ShowcaseDao,
    CoreCuttingDao,
    SettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Seed default data on first launch
        await _seedDefaults();
      },
    );
  }

  /// Seeds default saved items and core cutting rates so the app
  /// is useful from the very first launch
  Future<void> _seedDefaults() async {
    // Default saved items (common plumber charges)
    final defaultItems = [
      SavedItemsCompanion.insert(name: 'मजुरी (Labor)', defaultPrice: 500, sortOrder: const Value(1)),
      SavedItemsCompanion.insert(name: 'Pipe Fitting', defaultPrice: 300, sortOrder: const Value(2)),
      SavedItemsCompanion.insert(name: 'Valve Fitting', defaultPrice: 200, sortOrder: const Value(3)),
      SavedItemsCompanion.insert(name: 'Tap Installation', defaultPrice: 150, sortOrder: const Value(4)),
      SavedItemsCompanion.insert(name: 'Drainage Work', defaultPrice: 800, sortOrder: const Value(5)),
      SavedItemsCompanion.insert(name: 'Water Tank Connection', defaultPrice: 1000, sortOrder: const Value(6)),
      SavedItemsCompanion.insert(name: 'Core Cutting', defaultPrice: 250, sortOrder: const Value(7)),
      SavedItemsCompanion.insert(name: 'Bathroom Fitting', defaultPrice: 2000, sortOrder: const Value(8)),
    ];

    for (final item in defaultItems) {
      await into(savedItems).insert(item);
    }

    // Default core cutting rates (price per hole by size)
    final defaultRates = [
      CoreCuttingRatesCompanion.insert(holeSize: '2"', pricePerHole: 150, sortOrder: const Value(1)),
      CoreCuttingRatesCompanion.insert(holeSize: '3"', pricePerHole: 200, sortOrder: const Value(2)),
      CoreCuttingRatesCompanion.insert(holeSize: '4"', pricePerHole: 300, sortOrder: const Value(3)),
      CoreCuttingRatesCompanion.insert(holeSize: '6"', pricePerHole: 500, sortOrder: const Value(4)),
      CoreCuttingRatesCompanion.insert(holeSize: '8"', pricePerHole: 800, sortOrder: const Value(5)),
      CoreCuttingRatesCompanion.insert(holeSize: '10"', pricePerHole: 1200, sortOrder: const Value(6)),
      CoreCuttingRatesCompanion.insert(holeSize: '12"', pricePerHole: 1500, sortOrder: const Value(7)),
    ];

    for (final rate in defaultRates) {
      await into(coreCuttingRates).insert(rate);
    }

    // Default settings row (empty — first launch will prompt)
    await into(appSettings).insert(
      AppSettingsCompanion.insert(
        ownerName: '',
        ownerPhone: '',
        locale: const Value('mr'),
      ),
    );
  }
}

/// Opens the SQLite database file from the app's documents directory
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'plum.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
