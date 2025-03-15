// lib/controllers/preferences_controller.dart
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/note_style_model.dart';
import '../data/services/preferences_service.dart';
import '../ui/widgets/app_snackbar.dart';

class PreferencesController extends GetxController {
  final PreferencesService _preferencesService = PreferencesService();
  var isDarkMode = false.obs;
  static const String _noteStylePrefix = 'noteStyle_';

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  Future<void> loadTheme() async {
    try {
      isDarkMode.value = await _preferencesService.getTheme();
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesController - Load Theme Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show(
        'Error',
        'Failed to load theme preferences',
        isError: true,
      );
    }
  }

  Future<void> toggleTheme() async {
    try {
      isDarkMode.value = !isDarkMode.value;
      await _preferencesService.setTheme(isDarkMode.value);
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesController - Toggle Theme Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to toggle theme', isError: true);
    }
  }

  Future<void> saveNoteStyle(int noteId, NoteStyleModel style) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _noteStylePrefix + noteId.toString(),
        jsonEncode(style.toJson()),
      );
      AppSnackbar.show('Success', 'Note style saved successfully');
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesController - Save Note Style Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to save note style', isError: true);
    }
  }

  Future<NoteStyleModel?> loadNoteStyle(int noteId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final styleJson = prefs.getString(_noteStylePrefix + noteId.toString());
      if (styleJson != null) {
        return NoteStyleModel.fromJson(jsonDecode(styleJson));
      }
      return null;
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesController - Load Note Style Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to load note style', isError: true);
      return null;
    }
  }

  Future<void> clearNoteStyle(int noteId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_noteStylePrefix + noteId.toString());
      AppSnackbar.show('Success', 'Note style cleared successfully');
    } catch (e, stackTrace) {
      developer.log(
        'PreferencesController - Clear Note Style Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to clear note style', isError: true);
    }
  }
}
