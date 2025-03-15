// lib/data/models/note_model.dart
import 'package:intl/intl.dart';

class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id') ||
        !map.containsKey('title') ||
        !map.containsKey('content') ||
        !map.containsKey('createdAt')) {
      throw ArgumentError('Invalid map for NoteModel');
    }
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String getFormattedDate() {
    return DateFormat('yyyy-MM-dd HH:mm').format(createdAt);
  }

  String getShortContent() {
    if (content.length > 50) {
      return '${content.substring(0, 50)}...';
    }
    return content;
  }
}
