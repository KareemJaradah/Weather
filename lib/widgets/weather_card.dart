import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../screens/weather_detail_screen.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final Function onDelete;
  final Function onPin;

  WeatherCard({required this.weather, required this.onDelete, required this.onPin});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(weather.city),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.pin_drop, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onPin();
          return false; // Keep the item after pinning
        } else if (direction == DismissDirection.endToStart) {
          onDelete();
          return true; // Remove the item after deletion
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: weather);
        },
        child: Card(
          child: ListTile(
            title: Text(weather.city),
            subtitle: Text('${weather.temperature}°C'),
          ),
        ),
      ),
    );
  }
}
