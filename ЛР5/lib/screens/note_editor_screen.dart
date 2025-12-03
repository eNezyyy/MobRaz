import 'package:flutter/material.dart';
import 'package:weather_notes/models/note.dart';
import '../services/note_service.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isNewNote = true;

  @override
  void initState() {
    super.initState();
    
    if (widget.note != null) {
      _isNewNote = false;
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewNote ? 'Новая заметка' : 'Редактировать заметку'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (_titleController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Заголовок не может быть пустым')),
                );
                return;
              }
              
              if (_isNewNote) {
                // Create new note
                final newNote = Note(
                  title: _titleController.text.trim(),
                  content: _contentController.text.trim(),
                );
                await NoteService.addNote(newNote);
              } else {
                // Update existing note
                final updatedNote = Note(
                  id: widget.note!.id,
                  title: _titleController.text.trim(),
                  content: _contentController.text.trim(),
                  dateCreated: widget.note!.dateCreated,
                );
                await NoteService.updateNote(updatedNote);
              }
              
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Заголовок',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 16.0),
            // Content field
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Содержание',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}