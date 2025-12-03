import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const String _apiKey = 'YOUR_API_KEY'; // This will be replaced with a real API key later
  static const String _baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getCurrentWeather({String lat = '55.7558', String lon = '37.6173'}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru'),
      );

      if (response.statusCode == 200) {
        return Weather.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      // For layout phase, return mock data
      return Weather(
        temperature: 22.0,
        description: 'Облачно',
        icon: '04d', // This is a placeholder for the weather icon
        cityName: 'Москва',
      );
    }
  }

  // Method to get weather by city name
  Future<Weather> getWeatherByCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=ru'),
      );

      if (response.statusCode == 200) {
        return Weather.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      // For layout phase, return mock data
      return Weather(
        temperature: 22.0,
        description: 'Облачно',
        icon: '04d', // This is a placeholder for the weather icon
        cityName: city,
      );
    }
  }
}