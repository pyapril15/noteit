// lib/ui/screens/note_detail_screen.dart
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/note_controller.dart';
import '../../controllers/preferences_controller.dart';
import '../../data/models/note_model.dart';
import '../../data/models/note_style_model.dart';
import '../widgets/app_snackbar.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({super.key});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final NoteController _noteController = Get.find();
  final PreferencesController _prefsController = Get.find();
  NoteModel? note;

  TextStyle _currentTextStyle = const TextStyle();
  TextAlign _currentTextAlign = TextAlign.left;

  @override
  void initState() {
    super.initState();
    note = Get.arguments;
    if (note != null) {
      _titleController.text = note!.title;
      _contentController.text = note!.content;
      _loadNoteStyle();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadNoteStyle() async {
    if (note == null) return;
    try {
      final styleModel = await _prefsController.loadNoteStyle(note!.id!);
      if (styleModel != null) {
        setState(() {
          _currentTextStyle = TextStyle(
            fontWeight: styleModel.fontWeight,
            fontStyle: styleModel.fontStyle,
            decoration: styleModel.decoration,
            fontSize: styleModel.fontSize ?? 14.0,
            color:
                styleModel.color != null
                    ? Color(styleModel.color!)
                    : Colors.black,
            fontFamily: styleModel.fontFamily,
          );
          _currentTextAlign = styleModel.textAlign;
        });
      }
    } catch (e, stackTrace) {
      developer.log(
        'NoteDetailScreen - Load Note Style Error',
        error: e,
        stackTrace: stackTrace,
      );
      AppSnackbar.show('Error', 'Failed to load note style', isError: true);
    }
  }

  Future<void> _saveNote() async {
    final newNote = NoteModel(
      id: note?.id,
      title: _titleController.text,
      content: _contentController.text,
      createdAt: note?.createdAt ?? DateTime.now(),
    );
    try {
      if (note == null) {
        await _noteController.addNote(newNote);
        await _prefsController.saveNoteStyle(
          newNote.id!,
          NoteStyleModel(
            fontWeight: _currentTextStyle.fontWeight ?? FontWeight.normal,
            fontStyle: _currentTextStyle.fontStyle ?? FontStyle.normal,
            decoration: _currentTextStyle.decoration ?? TextDecoration.none,
            fontSize: _currentTextStyle.fontSize,
            color: _currentTextStyle.color?.toARGB32(),
            fontFamily: _currentTextStyle.fontFamily,
            textAlign: _currentTextAlign,
          ),
        );
        AppSnackbar.show('Success', 'Note added successfully');
        setState(() {
          note = newNote;
        });
      } else {
        await _noteController.updateNote(newNote);
        await _prefsController.saveNoteStyle(
          note!.id!,
          NoteStyleModel(
            fontWeight: _currentTextStyle.fontWeight ?? FontWeight.normal,
            fontStyle: _currentTextStyle.fontStyle ?? FontStyle.normal,
            decoration: _currentTextStyle.decoration ?? TextDecoration.none,
            fontSize: _currentTextStyle.fontSize,
            color: _currentTextStyle.color?.toARGB32(),
            fontFamily: _currentTextStyle.fontFamily,
            textAlign: _currentTextAlign,
          ),
        );
        AppSnackbar.show('Success', 'Note updated successfully');
      }
    } catch (e, stackTrace) {
      developer.log(
        'NoteDetailScreen - Save Note Error',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  void _updateTextStyle(TextStyle newStyle) {
    setState(() {
      _currentTextStyle = newStyle;
    });
  }

  void _updateTextAlign(TextAlign newAlign) {
    setState(() {
      _currentTextAlign = newAlign;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: _currentTextStyle,
                textAlign: _currentTextAlign,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.format_bold),
                  onPressed:
                      () => _updateTextStyle(
                        _currentTextStyle.copyWith(
                          fontWeight:
                              _currentTextStyle.fontWeight == FontWeight.bold
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                        ),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.format_italic),
                  onPressed:
                      () => _updateTextStyle(
                        _currentTextStyle.copyWith(
                          fontStyle:
                              _currentTextStyle.fontStyle == FontStyle.italic
                                  ? FontStyle.normal
                                  : FontStyle.italic,
                        ),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.format_underline),
                  onPressed:
                      () => _updateTextStyle(
                        _currentTextStyle.copyWith(
                          decoration:
                              _currentTextStyle.decoration ==
                                      TextDecoration.underline
                                  ? TextDecoration.none
                                  : TextDecoration.underline,
                        ),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.format_size),
                  onPressed:
                      () => _updateTextStyle(
                        _currentTextStyle.copyWith(
                          fontSize: _currentTextStyle.fontSize == 18 ? 14 : 18,
                        ),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.format_color_text),
                  onPressed:
                      () => _updateTextStyle(
                        _currentTextStyle.copyWith(
                          color:
                              _currentTextStyle.color == Colors.blue
                                  ? Colors.black
                                  : Colors.blue,
                        ),
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_left),
                  onPressed: () => _updateTextAlign(TextAlign.left),
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_center),
                  onPressed: () => _updateTextAlign(TextAlign.center),
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_right),
                  onPressed: () => _updateTextAlign(TextAlign.right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
