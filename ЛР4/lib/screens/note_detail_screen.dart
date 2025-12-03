import 'package:flutter/material.dart';
import 'package:weather_notes/models/note.dart';
import 'note_editor_screen.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditorScreen(note: note),
                ),
              ).then((value) {
                if (value == true) {
                  // Refresh the screen if note was updated
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Заметка обновлена')),
                  );
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Удалить заметку?'),
                  content: const Text('Вы уверены, что хотите удалить эту заметку?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, true); // Return true to indicate deletion
                      },
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Создано: ${_formatDate(note.dateCreated)}',
              style: const TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Обновлено: ${_formatDate(note.dateUpdated)}',
              style: const TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  note.content,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}