// lib/ui/screens/home_screen.dart
import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../controllers/note_controller.dart';
import '../../data/models/note_model.dart';
import '../widgets/app_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteController _noteController = Get.find<NoteController>();
  String _searchText = '';
  SortOption _sortOption = SortOption.date;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchText = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed(Routes.profile),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBarAndSortOptions(),
          Expanded(child: Obx(() => _buildNoteList())),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.note_detail),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBarAndSortOptions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchText.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchText = '';
                            });
                          },
                        )
                        : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (SortOption result) {
              setState(() {
                _sortOption = result;
              });
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<SortOption>>[
                  PopupMenuItem<SortOption>(
                    value: SortOption.date,
                    child: Row(
                      children: [
                        if (_sortOption == SortOption.date)
                          const Icon(Icons.check, color: Colors.blue),
                        const Text('Date (Latest)'),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortOption>(
                    value: SortOption.title,
                    child: Row(
                      children: [
                        if (_sortOption == SortOption.title)
                          const Icon(Icons.check, color: Colors.blue),
                        const Text('Title'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteList() {
    if (_noteController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    final notes = _filteredAndSortedNotes();

    if (notes.isEmpty) {
      if (_searchText.isNotEmpty) {
        return const Center(child: Text('No matching notes found.'));
      }
      return const Center(child: Text('No notes available.'));
    }

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
          key: Key(note.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) async {
            try {
              await _noteController.deleteNote(note.id!);
            } catch (e, stackTrace) {
              developer.log(
                'HomeScreen - Delete Note Error',
                error: e,
                stackTrace: stackTrace,
              );
              AppSnackbar.show('Error', 'Failed to delete note', isError: true);
            }
          },
          child: _buildNoteTile(note, index, context),
        );
      },
    );
  }

  List<NoteModel> _filteredAndSortedNotes() {
    List<NoteModel> filteredNotes =
        _noteController.notes
            .where(
              (note) =>
                  note.title.toLowerCase().contains(
                    _searchText.toLowerCase(),
                  ) ||
                  note.content.toLowerCase().contains(
                    _searchText.toLowerCase(),
                  ),
            )
            .toList();

    filteredNotes.sort((a, b) {
      if (_sortOption == SortOption.date) {
        return b.createdAt.compareTo(a.createdAt);
      } else {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }
    });

    return filteredNotes;
  }

  Widget _buildNoteTile(NoteModel note, int index, BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colorScheme.outlineVariant, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            child: Text('${index + 1}'),
          ),
          title: Text(
            note.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              note.getFormattedDate(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: theme.colorScheme.error),
            onPressed: () async {
              try {
                await _noteController.deleteNote(note.id!);
                AppSnackbar.show('Success', 'Note deleted successfully');
              } catch (e, stackTrace) {
                developer.log(
                  'HomeScreen - Delete Note Error',
                  error: e,
                  stackTrace: stackTrace,
                );
                AppSnackbar.show(
                  'Error',
                  'Failed to delete note',
                  isError: true,
                );
              }
            },
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          onTap: () => Get.toNamed(Routes.note_detail, arguments: note),
        ),
      ),
    );
  }
}

enum SortOption { date, title }
