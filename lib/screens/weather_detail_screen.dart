import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherDetailScreen extends StatelessWidget {
  final Weather weather;

  WeatherDetailScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${weather.city} Details'),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(weather.description),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7), // Semi-transparent background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${weather.city}',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${weather.temperature}°C',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${weather.description}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '༄ ${weather.windSpeed} m/s',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String description) {
    String imagePath;
    if (description.contains('clear')) {
      imagePath = 'lib/assets/images/sunny.jpg';
    } else if (description.contains('cloud')) {
      imagePath = 'lib/assets/images/cloudy.jpg';
    } else if (description.contains('thunderstorm')) {
      imagePath = 'lib/assets/images/rainy.jpg';
    } else {
      imagePath = 'lib/assets/images/default.jpg'; // Add a default image or handle other weather types
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
