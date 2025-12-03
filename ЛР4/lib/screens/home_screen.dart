import 'package:flutter/material.dart';
import 'package:weather_notes/models/note.dart';
import '../services/weather_service.dart';
import '../services/note_service.dart';
import 'note_editor_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock weather data for layout phase
  final String _temperature = "+22°C";
  final String _weatherDescription = "Облачно";
  final String _weatherIcon = "🌤️";

  // Mock notes data for layout phase
  final List<Note> _notes = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Notes'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Weather section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade100,
            child: Column(
              children: [
                const Text(
                  'Погода',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _weatherIcon,
                      style: const TextStyle(fontSize: 32.0),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      _temperature,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      _weatherDescription,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Notes list section
          Expanded(
            child: _notes.isEmpty
                ? const Center(
                    child: Text(
                      'Нет заметок. Создайте первую!',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final note = _notes[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12.0),
                          title: Text(
                            note.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              note.content.length > 100
                                  ? '${note.content.substring(0, 100)}...'
                                  : note.content,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoteDetailScreen(note: note),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteEditorScreen(),
            ),
          ).then((value) {
            if (value == true) {
              setState(() {}); // Refresh the list
            }
          });
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}