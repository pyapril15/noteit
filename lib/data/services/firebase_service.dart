// lib/data/services/firebase_service.dart
import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserData() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromJson(doc.data()!);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'FirebaseService - Get User Data Firebase Exception',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow; // Re-throw the exception
    } catch (e, stackTrace) {
      developer.log(
        'FirebaseService - Get User Data Error',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow; // Re-throw the exception
    }
  }

  Stream<UserModel?> getUserStream() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((doc) {
            if (doc.exists) {
              return UserModel.fromJson(doc.data()!);
            }
            return null;
          })
          .handleError((e, stackTrace) {
            developer.log(
              'FirebaseService - User Stream Error',
              error: e,
              stackTrace: stackTrace,
            );
            throw e; // Re-throw the error
          });
    }
    return Stream.value(null);
  }

  Future<void> updateUserData(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson());
    } on FirebaseException catch (e, stackTrace) {
      developer.log(
        'FirebaseService - Update User Data Firebase Exception',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e, stackTrace) {
      developer.log(
        'FirebaseService - Update User Data Error',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
