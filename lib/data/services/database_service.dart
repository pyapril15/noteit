// lib/data/services/database_service.dart
import 'dart:developer' as developer;
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class DatabaseService {
  static final Map<String, Database> _databases = {};

  Future<Database> getDatabase(String userId) async {
    if (_databases.containsKey(userId)) {
      return _databases[userId]!;
    }
    return _initDatabase(userId);
  }

  Future<Database> _initDatabase(String userId) async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$userId.db');
    final db = await openDatabase(path, version: 1, onCreate: _onCreate);
    _databases[userId] = db;
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<List<NoteModel>> getNotes(String userId) async {
    try {
      final db = await getDatabase(userId);
      final List<Map<String, dynamic>> maps = await db.query(
        'notes',
        orderBy: 'createdAt DESC',
      );
      return List.generate(maps.length, (i) {
        return NoteModel.fromMap(maps[i]);
      });
    } catch (e, stackTrace) {
      developer.log(
        'DatabaseService - Get Notes Error',
        error: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  Future<NoteModel?> getNote(int id, String userId) async {
    try {
      final db = await getDatabase(userId);
      final List<Map<String, dynamic>> maps = await db.query(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return NoteModel.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      developer.log(
        'DatabaseService - Get Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<int> insertNote(NoteModel note, String userId) async {
    try {
      final db = await getDatabase(userId);
      return await db.insert('notes', note.toMap());
    } catch (e, stackTrace) {
      developer.log(
        'DatabaseService - Insert Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      return -1;
    }
  }

  Future<int> updateNote(NoteModel note, String userId) async {
    try {
      final db = await getDatabase(userId);
      return await db.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e, stackTrace) {
      developer.log(
        'DatabaseService - Update Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      return -1;
    }
  }

  Future<int> deleteNote(int id, String userId) async {
    try {
      final db = await getDatabase(userId);
      return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    } catch (e, stackTrace) {
      developer.log(
        'DatabaseService - Delete Note Error',
        error: e,
        stackTrace: stackTrace,
      );
      return -1;
    }
  }
}
