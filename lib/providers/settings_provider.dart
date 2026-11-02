import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// App settings, saved with shared_preferences so they survive restarts.
class SettingsProvider with ChangeNotifier {
  static const _darkModeKey = 'darkMode';
  static const _autoplayKey = 'autoplay';

  final SharedPreferences _preferences;

  SettingsProvider(this._preferences);

  bool get darkMode => _preferences.getBool(_darkModeKey) ?? false;
  bool get autoplay => _preferences.getBool(_autoplayKey) ?? true;

  Future<void> setDarkMode(bool value) async {
    await _preferences.setBool(_darkModeKey, value);
    notifyListeners();
  }

  Future<void> setAutoplay(bool value) async {
    await _preferences.setBool(_autoplayKey, value);
    notifyListeners();
  }
}
