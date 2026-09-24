import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gère le thème clair / sombre / système de l'application et persiste
/// le choix de l'utilisateur avec [SharedPreferences].
class ThemeProvider extends ChangeNotifier {
  static const _prefsKey = 'theme_mode';

  final SharedPreferences _prefs;
  late ThemeMode _themeMode;

  ThemeProvider(this._prefs) {
    _themeMode = _readInitial(_prefs);
  }

  static ThemeMode _readInitial(SharedPreferences prefs) {
    final stored = prefs.getString(_prefsKey);
    switch (stored) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    _prefs.setString(_prefsKey, mode.name);
    notifyListeners();
  }

  void toggleDarkLight() {
    setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
