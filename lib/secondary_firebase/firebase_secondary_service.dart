// lib/secondary_firebase/firebase_secondary_service.dart
import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../ui/widgets/app_snackbar.dart';
import 'firebase_options_secondary.dart';

class FirebaseSecondaryService {
  static FirebaseApp? _secondaryApp;
  static FirebaseStorage? _secondaryStorage;

  static Future<FirebaseApp> initializeSecondaryFirebaseApp() async {
    try {
      _secondaryApp = await Firebase.initializeApp(
        name: 'SecondaryApp',
        options: DefaultFirebaseOptionsSecondary.currentPlatform,
      );
      _secondaryStorage = FirebaseStorage.instanceFor(app: _secondaryApp!);
      return _secondaryApp!;
    } catch (e, stackTrace) {
      developer.log(
        "FirebaseSecondaryService - Initialize Secondary Firebase App Error",
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show(
        'Error',
        'Error initializing secondary Firebase app.',
        isError: true,
      );
      rethrow;
    }
  }

  static FirebaseStorage getSecondaryStorage() {
    if (_secondaryStorage == null) {
      developer.log(
        "FirebaseSecondaryService - Secondary Storage Not Initialized Error",
      );
      AppSnackbar.show(
        'Error',
        'Secondary Firebase Storage not initialized.',
        isError: true,
      );
      throw Exception("Secondary Firebase Storage not initialized.");
    }
    return _secondaryStorage!;
  }

  static Future<void> deleteSecondaryApp() async {
    if (_secondaryApp != null) {
      try {
        await _secondaryApp!.delete();
        _secondaryApp = null;
        _secondaryStorage = null;
      } catch (e, stackTrace) {
        developer.log(
          "FirebaseSecondaryService - Delete Secondary App Error",
          error: e,
          stackTrace: stackTrace,
        );
        AppSnackbar.show(
          'Error',
          'Error deleting secondary Firebase app.',
          isError: true,
        );
      }
    }
  }

  static bool isSecondaryAppInitialized() {
    return _secondaryApp != null;
  }

  static FirebaseApp? getSecondaryAppInstance() {
    return _secondaryApp;
  }
}
