// lib/controllers/remember_me_controller.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/widgets/app_snackbar.dart';

class RememberMeController extends GetxController {
  var rememberMe = false.obs;
  var rememberedEmail = ''.obs;
  var rememberedPassword = ''.obs;
  final _secureStorage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    loadRememberMe();
  }

  Future<void> loadRememberMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      rememberMe.value = prefs.getBool('rememberMe') ?? false;
      if (rememberMe.value) {
        rememberedEmail.value = prefs.getString('rememberedEmail') ?? '';
        rememberedPassword.value =
            await _secureStorage.read(key: 'rememberedPassword') ?? '';
      }
    } catch (e) {
      AppSnackbar.show(
        'Error',
        'Failed to load remember me preferences: $e',
        isError: true,
      );
    }
  }

  Future<void> saveRememberMe(bool value, String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      rememberMe.value = value;
      prefs.setBool('rememberMe', value);
      if (value) {
        prefs.setString('rememberedEmail', email);
        await _secureStorage.write(key: 'rememberedPassword', value: password);
      } else {
        prefs.remove('rememberedEmail');
        await _secureStorage.delete(key: 'rememberedPassword');
      }
    } catch (e) {
      AppSnackbar.show(
        'Error',
        'Failed to save remember me preferences: $e',
        isError: true,
      );
    }
  }

  Future<void> clearRememberMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('rememberMe');
      prefs.remove('rememberedEmail');
      await _secureStorage.delete(key: 'rememberedPassword');
      rememberMe.value = false;
      rememberedEmail.value = '';
      rememberedPassword.value = '';
    } catch (e) {
      AppSnackbar.show(
        'Error',
        'Failed to clear remember me preferences: $e',
        isError: true,
      );
    }
  }
}
