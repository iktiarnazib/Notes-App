import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_database.dart';

// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// Notes provider — Note type comes from generated code
final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  final db = ref.watch(databaseProvider);
  return NoteNotifier(db);
});

class NoteNotifier extends StateNotifier<List<Note>> {
  final AppDatabase db;

  NoteNotifier(this.db) : super([]) {
    fetchNotes();
  }

  // READ
  Future<void> fetchNotes() async {
    final fetchedNotes =
        await (db.select(db.notes)..orderBy([
              (t) => OrderingTerm(
                expression: t.timestamp,
                mode: OrderingMode.desc,
              ),
            ]))
            .get();

    state = fetchedNotes;
  }

  // CREATE
  Future<void> addNote({
    required String noteText,
    required String noteSubText,
  }) async {
    await db
        .into(db.notes)
        .insert(
          NotesCompanion.insert(
            noteText: noteText,
            noteSubText: Value(noteSubText),
            timestamp: Value(DateTime.now()), // ← explicitly pass current time
          ),
        );
    await fetchNotes();
  }

  // UPDATE
  Future<void> updateNote({
    required int id,
    required String newText,
    required String newSubText,
    required DateTime timeStamp,
  }) async {
    await (db.update(db.notes)..where((t) => t.id.equals(id))).write(
      NotesCompanion(
        noteText: Value(newText),
        noteSubText: Value(newSubText),
        timestamp: Value(timeStamp),
      ),
    );
    await fetchNotes();
  }

  // DELETE
  Future<void> deleteNote(int id) async {
    await (db.delete(db.notes)..where((t) => t.id.equals(id))).go();
    await fetchNotes();
  }
}
