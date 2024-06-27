import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/weather_bloc.dart';
import '../blocs/weather_event.dart';
import '../blocs/weather_state.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newCity = await Navigator.pushNamed(context, '/city');
              if (newCity != null) {
                BlocProvider.of<WeatherBloc>(context).add(AddCity(newCity as String));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            BlocProvider.of<WeatherBloc>(context).add(FetchWeather('New York'));
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return ListView.builder(
              itemCount: state.weatherList.length,
              itemBuilder: (context, index) {
                return WeatherCard(
                  weather: state.weatherList[index],
                  onDelete: () {
                    BlocProvider.of<WeatherBloc>(context).add(DeleteCity(index));
                  },
                  onPin: () {
                    BlocProvider.of<WeatherBloc>(context).add(PinCity(index));
                  },
                );
              },
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
