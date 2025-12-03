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
  List<Note> _notes = [];
  String _temperature = "Загрузка...";
  String _weatherDescription = "Погода";
  String _weatherIcon = "🌤️";
  bool _isLoading = true;
  
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _loadNotesAndWeather();
  }

  Future<void> _loadNotesAndWeather() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      // Load notes
      final notes = await NoteService.getAllNotes();
      // Load weather
      final weather = await _weatherService.getCurrentWeather();
      
      setState(() {
        _notes = notes;
        _temperature = "${weather.temperature.toStringAsFixed(0)}°C";
        _weatherDescription = weather.description;
        _weatherIcon = _getWeatherIcon(weather.icon);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading data: $e');
    }
  }
  
  String _getWeatherIcon(String iconCode) {
    // Map weather icon codes to emojis
    switch (iconCode) {
      case '01d': // clear sky day
      case '01n': // clear sky night
        return '☀️';
      case '02d': // few clouds day
      case '02n': // few clouds night
        return '⛅';
      case '03d': // scattered clouds
      case '03n':
      case '04d': // broken clouds
      case '04n':
        return '☁️';
      case '09d': // shower rain
      case '09n':
      case '10d': // rain day
      case '10n': // rain night
        return '🌧️';
      case '11d': // thunderstorm
      case '11n':
        return '⛈️';
      case '13d': // snow
      case '13n':
        return '❄️';
      case '50d': // mist
      case '50n':
        return '🌫️';
      default:
        return '🌤️';
    }
  }

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