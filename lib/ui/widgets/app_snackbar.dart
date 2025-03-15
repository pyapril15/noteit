// lib/ui/widgets/app_snackbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void show(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }
}
