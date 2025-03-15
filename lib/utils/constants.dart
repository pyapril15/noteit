import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/preferences_controller.dart';

class AppString {
  String splashScreenHeadline = "Notes App";
}

// Gradient Colors
class AppGradients {
  LinearGradient authGradient() {
    bool isDarkMode = Get.find<PreferencesController>().isDarkMode.value;
    return LinearGradient(
      colors:
          isDarkMode
              ? [Color(0xFF303030), Color(0xFF424242)]
              : [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  LinearGradient splashGradient() {
    bool isDarkMode = Get.find<PreferencesController>().isDarkMode.value;
    return LinearGradient(
      colors:
          isDarkMode
              ? [Color(0xFF424242), Color(0xFF616161)]
              : [Color(0xFF81D4FA), Color(0xFF4FC3F7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

// Icons
class AppIcons {
  Icon getSplashScreenIcon() {
    bool isDarkMode = Get.find<PreferencesController>().isDarkMode.value;
    return Icon(
      Icons.security,
      size: 100,
      color: isDarkMode ? Colors.white : Colors.blue[400],
    );
  }

  Icon getLoginScreenIcon() {
    bool isDarkMode = Get.find<PreferencesController>().isDarkMode.value;
    return Icon(
      Icons.person,
      size: 50,
      color: isDarkMode ? Colors.white : Colors.blue[400],
    );
  }

  Icon getSignupScreenIcon() {
    bool isDarkMode = Get.find<PreferencesController>().isDarkMode.value;
    return Icon(
      Icons.person_add,
      size: 50,
      color: isDarkMode ? Colors.white : Colors.blue[400],
    );
  }

  Icon getForgotScreenIcon() {
    bool isDarkMode = Get.find<PreferencesController>().isDarkMode.value;
    return Icon(
      Icons.lock_reset,
      size: 50,
      color: isDarkMode ? Colors.white : Colors.blue[400],
    );
  }
}

// Constants
class AppConstants {
  static final AppString appStrings = AppString();
  static final AppIcons appIcons = AppIcons();
  static final AppGradients appGradients = AppGradients();
}
