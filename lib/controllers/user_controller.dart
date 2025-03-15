import 'dart:developer' as developer;

import 'package:get/get.dart';

import '../data/models/user_model.dart';
import '../data/services/firebase_service.dart';
import '../ui/widgets/app_snackbar.dart';

class UserController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var user = Rxn<UserModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    _startUserListener();
  }

  void _startUserListener() {
    _firebaseService.getUserStream().listen(
      (updatedUser) {
        user.value = updatedUser;
      },
      onError: (error, stackTrace) {
        developer.log(
          'UserController - User Stream Error',
          error: error,
          stackTrace: stackTrace,
        );
        AppSnackbar.show(
          'Error',
          'Failed to listen for user updates.',
          isError: true,
        ); // Use AppSnackbar
      },
    );
  }

  Future<void> fetchUserData() async {
    isLoading(true);
    try {
      user.value = await _firebaseService.getUserData();
    } catch (e, stackTrace) {
      developer.log(
        'UserController - Failed to fetch user data',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show(
        'Error',
        'Failed to fetch user data. Please check your internet connection.',
        isError: true,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUserData(UserModel updatedUser) async {
    isLoading(true);
    try {
      await _firebaseService.updateUserData(updatedUser);
      AppSnackbar.show(
        'Success',
        'Profile updated successfully',
      ); // Use AppSnackbar
    } catch (e, stackTrace) {
      developer.log(
        'UserController - Failed to update profile',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show(
        'Error',
        'Failed to update profile. Please try again later.',
        isError: true,
      );
    } finally {
      isLoading(false);
    }
  }

  void clearUserData() {
    user.value = null;
  }

  Future<void> refreshUserData() async {
    fetchUserData();
  }
}
