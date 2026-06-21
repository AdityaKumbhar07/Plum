# Plum — Project Setup Guide

Run these steps **in order**. Each step has the exact command and what to expect.

---

## Step 0: Prerequisites Check

Run these in your terminal to verify everything is installed:

```powershell
# Check Flutter is installed and on PATH
flutter --version
# Expected: Flutter 3.x.x • channel stable

# Check Dart SDK (comes with Flutter)
dart --version
# Expected: Dart SDK version 3.x.x

# Check Android SDK is configured
flutter doctor
# Expected: All green checkmarks for Flutter, Android toolchain, Android Studio
# It's OK if Chrome/VS Code show warnings — we only need Android
```

> [!WARNING]
> If `flutter` is not recognized, you need to [install Flutter SDK](https://docs.flutter.dev/get-started/install/windows/mobile) and add it to your system PATH first. Everything else depends on this.

---

## Step 1: Create Flutter Project

```powershell
# Navigate to project parent directory
cd d:\College\Project

# Create the Flutter project (this creates the plum/ folder with all boilerplate)
flutter create --org com.plum --platforms android --project-name plum plum
```

**What this does:**
- Creates `d:\College\Project\plum\` with full Flutter scaffold
- Sets package name to `com.plum.plum`
- Only generates Android platform files (no iOS/web/desktop junk)

**Expected output:** `All done! Run "flutter run" to start your app.`

> [!NOTE]
> If `d:\College\Project\plum` already exists and is empty, the command will still work. If it has files, you may need to clear it first.

---

## Step 2: Install Dependencies

Open `d:\College\Project\plum\pubspec.yaml` and **replace its entire contents** with:

```yaml
name: plum
description: Indie tradesman app for plumber & core cutter
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.7.0

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # Database (Drift ORM + SQLite)
  drift: ^2.26.0
  sqlite3_flutter_libs: ^0.5.28

  # State Management
  provider: ^6.1.5

  # PDF Generation
  pdf: ^3.12.0

  # Sharing & Launching
  share_plus: ^10.1.4
  url_launcher: ^6.3.1

  # Camera & Photos
  image_picker: ^1.1.2

  # File System
  path_provider: ^2.1.5
  path: ^1.9.1

  # Localization
  intl: any

  # UI Helpers
  google_fonts: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

  # Drift code generator
  drift_dev: ^2.26.0
  build_runner: ^2.4.15

flutter:
  generate: true   # Enables automatic localization code generation
  uses-material-design: true
```

Then run:

```powershell
cd d:\College\Project\plum
flutter pub get
```

**What this downloads (13 packages):**

| Package | Size | Purpose |
|---|---|---|
| `drift` | ~2 MB | Type-safe SQLite ORM with reactive queries |
| `sqlite3_flutter_libs` | ~8 MB | Pre-built SQLite binaries for Android |
| `provider` | ~200 KB | State management (language toggle, cart, etc.) |
| `pdf` | ~1 MB | Generate bill PDFs programmatically |
| `share_plus` | ~300 KB | Native Android share sheet (for PDF sharing) |
| `url_launcher` | ~200 KB | Open WhatsApp via `wa.me` deep links |
| `image_picker` | ~400 KB | Camera capture + gallery picker |
| `path_provider` | ~150 KB | Find app's local storage directory |
| `path` | ~50 KB | File path manipulation utilities |
| `intl` | ~500 KB | Internationalization (date/number formatting) |
| `google_fonts` | ~100 KB | Noto Sans Devanagari for Marathi text |
| `drift_dev` | ~3 MB | Code generator for Drift (dev only) |
| `build_runner` | ~1 MB | Runs code generation (dev only) |

**Expected output:** `Got dependencies!` with no errors.

> [!IMPORTANT]
> If you see version conflicts, run `flutter pub upgrade --major-versions` to resolve them.

---

## Step 3: Create Localization Config

Create a new file `d:\College\Project\plum\l10n.yaml` with:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

This tells Flutter where to find translation files and what to generate.

---

## Step 4: Create Folder Structure

Run this in PowerShell to create all directories at once:

```powershell
cd d:\College\Project\plum

# Database layer
mkdir -p lib/database/tables
mkdir -p lib/database/daos

# Models, Providers, Services
mkdir -p lib/models
mkdir -p lib/providers
mkdir -p lib/services

# Screens (one folder per feature)
mkdir -p lib/screens/dashboard
mkdir -p lib/screens/customers
mkdir -p lib/screens/bills/widgets
mkdir -p lib/screens/quotations
mkdir -p lib/screens/payments
mkdir -p lib/screens/calculator
mkdir -p lib/screens/showcase
mkdir -p lib/screens/settings

# Shared widgets & theme
mkdir -p lib/widgets
mkdir -p lib/theme

# Localization files
mkdir -p lib/l10n
```

**Resulting structure:**
```
plum/lib/
├── database/
│   ├── tables/       ← 9 Drift table definitions
│   └── daos/         ← 7 Data Access Objects
├── models/           ← View models (bill_with_items, cart_item, etc.)
├── providers/        ← Provider classes (locale, cart, database)
├── services/         ← Business logic (PDF, sharing, photos)
├── screens/          ← 8 feature folders, each with its screen(s)
│   ├── dashboard/
│   ├── customers/
│   ├── bills/widgets/
│   ├── quotations/
│   ├── payments/
│   ├── calculator/
│   ├── showcase/
│   └── settings/
├── widgets/          ← Shared reusable components
├── theme/            ← Colors, text styles, component themes
├── l10n/             ← app_en.arb + app_mr.arb translation files
└── main.dart
```

---

## Step 5: Android Manifest Permissions

Open `d:\College\Project\plum\android\app\src\main\AndroidManifest.xml`

Add these permissions **above** the `<application` tag:

```xml
<!-- Camera access for work showcase photos -->
<uses-permission android:name="android.permission.CAMERA"/>

<!-- Storage for saving photos and PDFs -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

<!-- WhatsApp deep link queries -->
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
    <intent>
        <action android:name="android.intent.action.SEND" />
        <data android:mimeType="*/*" />
    </intent>
</queries>
```

---

## Step 6: Verify Everything Works

```powershell
cd d:\College\Project\plum

# Check for any issues
flutter analyze

# Build a debug APK (first build takes 2-5 minutes)
flutter build apk --debug
```

**Expected:** Build succeeds with `✓ Built build\app\outputs\flutter-apk\app-debug.apk`

---

## Summary — What Gets Downloaded

| Category | Packages | Total ~Size |
|---|---|---|
| Database | drift, sqlite3_flutter_libs | ~10 MB |
| PDF & Sharing | pdf, share_plus, url_launcher | ~1.5 MB |
| Camera & Files | image_picker, path_provider, path | ~600 KB |
| Localization | intl, flutter_localizations (SDK) | ~500 KB |
| UI | google_fonts, provider | ~300 KB |
| Dev tools | drift_dev, build_runner | ~4 MB (dev only) |
| **Total** | **13 packages** | **~17 MB download** |

> [!TIP]
> The dev-only packages (`drift_dev`, `build_runner`) are NOT included in your final APK — they only run during development for code generation. Your actual app stays lean.

---

## Next Steps (After Setup)

Once all 6 steps above are done, tell me and I'll start writing the actual code in this order:

1. `[ ]` Theme + App Shell (main.dart, bottom nav, theme)
2. `[ ]` Database Layer (all tables + DAOs)
3. `[ ]` Settings Screen + First Launch
4. `[ ]` Customer Management
5. `[ ]` Saved Items Manager
6. `[ ]` Quick Bill (बिल) + PDF
7. `[ ]` Quotation + Payments + Calculator
8. `[ ]` Work Showcase Gallery
