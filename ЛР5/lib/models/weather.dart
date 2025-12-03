class Weather {
  final double temperature;
  final String description;
  final String icon;
  final String cityName;

  Weather({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.cityName,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      temperature: (map['main']['temp'] as num).toDouble(),
      description: map['weather'][0]['description'],
      icon: map['weather'][0]['icon'],
      cityName: map['name'],
    );
  }
}