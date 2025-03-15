import 'dart:developer' as developer;
import 'dart:io' show Platform;

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'controllers/auth_controller.dart';
import 'controllers/preferences_controller.dart';
import 'controllers/user_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      FirebaseAppCheck.instance.activate(
        webProvider: ReCaptchaV3Provider(
          '6LdRkfQqAAAAANs1EsAq6g6NCt7dFHdmvfTjxlON',
        ),
      );
    } else {
      await FirebaseAppCheck.instance.activate(
        androidProvider: AndroidProvider.playIntegrity,
        // appleProvider: AppleProvider.debug,
      );
    }

    await Get.putAsync(() async => AuthController());
    await Get.putAsync(() async => UserController());
    await Get.putAsync(() async => PreferencesController());

    runApp(App());
  } catch (e, stackTrace) {
    developer.log(
      'Firebase Initialization Error:',
      error: e,
      stackTrace: stackTrace,
    );
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Failed to initialize Firebase: $e')),
        ),
      ),
    );
  }
}
