import '../models/note.dart';

class NoteService {
  // Mock list of notes for layout phase
  static List<Note> _notes = [
    Note(
      id: 1,
      title: "Заголовок заметки 1",
      content: "Краткое содержание первой заметки...",
      dateCreated: DateTime.now(),
      dateUpdated: DateTime.now(),
    ),
    Note(
      id: 2,
      title: "Вторая заметка",
      content: "Пример содержания второй заметки с более длинным текстом...",
      dateCreated: DateTime.now(),
      dateUpdated: DateTime.now(),
    ),
  ];

  // Get all notes
  static Future<List<Note>> getAllNotes() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return _notes;
  }

  // Get note by ID
  static Future<Note?> getNoteById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return _notes.firstWhere((note) => note.id == id);
  }

  // Add a new note
  static Future<void> addNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    note.id = _notes.isEmpty ? 1 : _notes.last.id! + 1;
    note.dateCreated = DateTime.now();
    note.dateUpdated = DateTime.now();
    _notes.add(note);
  }

  // Update existing note
  static Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    note.dateUpdated = DateTime.now();
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    }
  }

  // Delete note
  static Future<void> deleteNote(int id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    _notes.removeWhere((note) => note.id == id);
  }
}