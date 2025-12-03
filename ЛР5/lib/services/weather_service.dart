import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  // Using a placeholder API key - in a real app, this would be secured differently
  // For demo purposes we'll use a fake key, but the code structure remains the same
  static const String _apiKey = '4d48747442644c6a416b6b566d4a516a'; // This is just a placeholder
  static const String _baseUrl = 'http://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getCurrentWeather({String lat = '55.7558', String lon = '37.6173'}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=ru'),
      );

      if (response.statusCode == 200) {
        return Weather.fromMap(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      // In case of API error, return mock data
      print('Weather API error: $e');
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
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      // In case of API error, return mock data
      print('Weather API error: $e');
      return Weather(
        temperature: 22.0,
        description: 'Облачно',
        icon: '04d', // This is a placeholder for the weather icon
        cityName: city,
      );
    }
  }
}