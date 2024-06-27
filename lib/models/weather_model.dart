class Weather {
  final String city;
  final double temperature;
  final String description;
  final int humidity;
  // final double morningtemp;
  final double windSpeed;
  final bool isPinned;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
        // required this.morningtemp,
    required this.windSpeed,
    this.isPinned = false,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      //  morningtemp: json['temp']['daily']["morn"].toDouble(),

      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
