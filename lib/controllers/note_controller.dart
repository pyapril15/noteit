// lib/controllers/note_controller.dart
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io' as io;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:noteit/data/models/note_model.dart';
import 'package:noteit/data/services/database_service.dart';
import 'package:noteit/ui/widgets/app_snackbar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class NoteController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();
  var notes = <NoteModel>[].obs;
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamSubscription<User?> _authStateSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
    _authStateSubscription = _auth.authStateChanges().listen((
      User? user,
    ) async {
      if (user == null) {
        clearNotes();
      } else {
        await Future.delayed(Duration(milliseconds: 100));
        fetchNotes();
      }
    });
  }

  @override
  void onClose() {
    _authStateSubscription.cancel();
    super.onClose();
  }

  Future<void> fetchNotes() async {
    isLoading(true);
    try {
      if (_auth.currentUser == null) {
        AppSnackbar.show('Error', 'User not authenticated', isError: true);
        return;
      }
      final userId = _auth.currentUser!.uid;
      developer.log('Fetching notes for user: $userId');

      io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, '$userId.db');
      developer.log('Database Path: $path');

      notes.value = await _databaseService.getNotes(userId);
    } catch (e, stackTrace) {
      developer.log(
        'NoteController - Fetch Notes Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to fetch notes', isError: true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      if (_auth.currentUser == null) {
        AppSnackbar.show('Error', 'User not authenticated', isError: true);
        return;
      }
      final userId = _auth.currentUser!.uid;
      await _databaseService.insertNote(note, userId);
      fetchNotes();
      AppSnackbar.show('Success', 'Note added successfully');
    } catch (e, stackTrace) {
      developer.log(
        'NoteController - Add Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to add note', isError: true);
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      if (_auth.currentUser == null) {
        AppSnackbar.show('Error', 'User not authenticated', isError: true);
        return;
      }
      final userId = _auth.currentUser!.uid;
      await _databaseService.updateNote(note, userId);
      fetchNotes();
    } catch (e, stackTrace) {
      developer.log(
        'NoteController - Update Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to update note', isError: true);
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      if (_auth.currentUser == null) {
        AppSnackbar.show('Error', 'User not authenticated', isError: true);
        return;
      }
      final userId = _auth.currentUser!.uid;
      await _databaseService.deleteNote(id, userId);
      fetchNotes();
      AppSnackbar.show('Success', 'Note deleted successfully');
    } catch (e, stackTrace) {
      developer.log(
        'NoteController - Delete Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to delete note', isError: true);
    }
  }

  void clearNotes() {
    notes.clear();
  }
}
