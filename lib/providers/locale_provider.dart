import 'package:flutter/material.dart';

/// Manages the app locale (English / Marathi) with persistence via settings DB
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isMarathi => _locale.languageCode == 'mr';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggleLocale() {
    _locale = isMarathi ? const Locale('en') : const Locale('mr');
    notifyListeners();
  }
}
