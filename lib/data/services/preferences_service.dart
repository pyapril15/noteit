// lib/data/services/preferences_service.dart
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String themeKey = 'theme';
  static const String stringKey = 'string_preference';
  static const String intKey = 'int_preference';
  static const String doubleKey = 'double_preference';

  Future<bool> getTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(themeKey) ?? false;
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Get Theme Error',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  Future<void> setTheme(bool isDark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(themeKey, isDark);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Set Theme Error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<String?> getStringPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(stringKey);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Get String Preference Error',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> setStringPreference(String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(stringKey, value);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Set String Preference Error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<int?> getIntPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(intKey);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Get Int Preference Error',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> setIntPreference(int value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(intKey, value);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Set Int Preference Error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<double?> getDoublePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(doubleKey);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Get Double Preference Error',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> setDoublePreference(double value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(doubleKey, value);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesService - Set Double Preference Error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
