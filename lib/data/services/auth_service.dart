// lib/data/services/auth_service.dart
import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();
        return userCredential;
      } else {
        throw FirebaseAuthException(
          code: 'user-not-created',
          message: 'User could not be created',
        );
      }
    } on FirebaseAuthException catch (e) {
      developer.log('AuthService - Signup Error', error: e);
      rethrow;
    } catch (e, stackTrace) {
      developer.log(
        'AuthService - Unexpected Signup Error',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Email not verified. Verification email sent.',
        );
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      developer.log('AuthService - Login Error', error: e);
      rethrow;
    } catch (e, stackTrace) {
      developer.log(
        'AuthService - Unexpected Login Error',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e, stackTrace) {
      developer.log(
        'AuthService - Sign out Error',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      developer.log('AuthService - Reset Password Error', error: e);
      rethrow;
    } catch (e, stackTrace) {
      developer.log(
        'AuthService - Unexpected Reset Password Error',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
