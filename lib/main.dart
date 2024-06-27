import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/weather_bloc.dart';
import 'services/weather_service.dart';
import 'screens/home_screen.dart';
import 'screens/city_screen.dart';
import 'screens/weather_detail_screen.dart';
import 'models/weather_model.dart';

void main() {
  final WeatherService weatherService = WeatherService();
  runApp(MyApp(weatherService: weatherService));
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService;

  MyApp({required this.weatherService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(weatherService),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => HomeScreen());
            case '/city':
              return MaterialPageRoute(builder: (context) => CityScreen());
            case '/detail':
              final weather = settings.arguments as Weather;
              return MaterialPageRoute(builder: (context) => WeatherDetailScreen(weather: weather));
            default:
              return MaterialPageRoute(builder: (context) => HomeScreen());
          }
        },
      ),
    );
  }
}
