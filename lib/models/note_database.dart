import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/note.dart';

// PROVIDER
final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]) {
    initialize(); // load data when created
  }

  late Isar isar;

  // Initialize DB
  Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);

    await fetchNotes();
  }

  // READ
  Future<void> fetchNotes() async {
    final fetchedNotes = await isar.notes.where().findAll();
    state =
        fetchedNotes; // 🔥 notifyListeners equivalent//finds all the value and sets to the notes
  }

  // CREATE
  Future<void> addNote(String text) async {
    final newNote = Note()..text = text;

    await isar.writeTxn(() => isar.notes.put(newNote));

    await fetchNotes(); // refresh state
  }

  // UPDATE
  Future<void> updateNote(int id, String newText) async {
    final note = await isar.notes.get(id);

    if (note != null) {
      note.text = newText;

      await isar.writeTxn(() => isar.notes.put(note));

      await fetchNotes();
    }
  }

  // DELETE
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));

    await fetchNotes();
  }
}
