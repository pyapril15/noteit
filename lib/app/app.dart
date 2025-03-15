import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes.dart';
import '../app/theme.dart';
import '../controllers/preferences_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final PreferencesController preferencesController =
        Get.find<PreferencesController>();
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
            preferencesController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
        initialRoute: Routes.initialRoute,
        getPages: Routes.pages,
      );
    });
  }
}
