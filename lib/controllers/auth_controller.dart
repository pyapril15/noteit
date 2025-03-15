// lib/controllers/auth_controller.dart
import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/routes.dart';
import '../data/services/auth_service.dart';
import '../ui/widgets/app_snackbar.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  User? get currentUser => _auth.currentUser;
  var isLoading = false.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signup(String name, String email, String password) async {
    if (!signupFormKey.currentState!.validate()) {
      return;
    }
    isLoading(true);
    try {
      await _authService.createUserWithEmailAndPassword(
        email.trim(),
        password.trim(),
      );
      await _auth.currentUser?.updateDisplayName(name.trim());
      AppSnackbar.show(
        'Success',
        'Signup successful! Please check your email for verification.',
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.show('Error', e.message ?? 'Signup failed', isError: true);
      developer.log('AuthController - Signup Error', error: e);
    } catch (e, stackTrace) {
      AppSnackbar.show('Error', 'Unexpected Signup Error', isError: true);
      developer.log(
        'AuthController - Unexpected Signup Error',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    isLoading(true);
    try {
      await _authService.loginWithEmailAndPassword(
        email.trim(),
        password.trim(),
      );
      Get.offAllNamed(Routes.home);
      AppSnackbar.show('Success', 'Login successful!');
    } on FirebaseAuthException catch (e) {
      AppSnackbar.show('Error', e.message ?? 'Login failed', isError: true);
      developer.log('AuthController - Login Error', error: e);
    } catch (e, stackTrace) {
      AppSnackbar.show('Error', 'Unexpected Login Error', isError: true);
      developer.log(
        'AuthController - Unexpected Login Error',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(Routes.login);
      AppSnackbar.show('Success', 'Logout successful!');
    } catch (e, stackTrace) {
      AppSnackbar.show('Error', 'Logout failed', isError: true);
      developer.log(
        'AuthController - Logout Error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> resendVerificationEmail() async {
    isLoading(true);
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        AppSnackbar.show('Success', 'Verification email resent.');
      }
    } on FirebaseAuthException catch (e) {
      AppSnackbar.show(
        'Error',
        e.message ?? 'Failed to resend verification email.',
        isError: true,
      );
      developer.log('AuthController - Resend Verification Error', error: e);
    } catch (e, stackTrace) {
      AppSnackbar.show(
        'Error',
        'Unexpected Resend Verification Error',
        isError: true,
      );
      developer.log(
        'AuthController - Unexpected Resend Verification Error',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> forgotPassword(String email) async {
    if (!forgotPasswordFormKey.currentState!.validate()) {
      return;
    }
    isLoading(true);
    try {
      await _authService.resetPassword(email.trim());
      AppSnackbar.show('Success', 'Password reset email sent.');
    } on FirebaseAuthException catch (e) {
      AppSnackbar.show(
        'Error',
        e.message ?? 'Failed to send password reset email.',
        isError: true,
      );
      developer.log('AuthController - Forgot Password Error', error: e);
    } catch (e, stackTrace) {
      AppSnackbar.show(
        'Error',
        'Unexpected Forgot Password Error',
        isError: true,
      );
      developer.log(
        'AuthController - Unexpected Forgot Password Error',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      isLoading(false);
    }
  }
}
