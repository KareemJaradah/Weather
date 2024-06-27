import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<AddCity>(_onAddCity);
    on<DeleteCity>(_onDeleteCity);
    on<PinCity>(_onPinCity);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherService.fetchWeather(event.city);
      emit(WeatherLoaded([weather]));
    } catch (e) {
      emit(WeatherError('Failed to fetch weather data. Please try again.'));
    }
  }

  void _onAddCity(AddCity event, Emitter<WeatherState> emit) async {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      emit(WeatherLoading());
      try {
        final newWeather = await weatherService.fetchWeather(event.city);
        final updatedWeatherList = List<Weather>.from(currentState.weatherList)..add(newWeather);
        emit(WeatherLoaded(updatedWeatherList));
      } catch (e) {
        emit(WeatherError('Failed to fetch weather data. Please try again.'));
        emit(currentState); // Revert back to the previous state
      }
    }
  }

  void _onDeleteCity(DeleteCity event, Emitter<WeatherState> emit) async {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      final updatedWeatherList = List<Weather>.from(currentState.weatherList)..removeAt(event.index);
      emit(WeatherLoaded(updatedWeatherList));
    }
  }

  void _onPinCity(PinCity event, Emitter<WeatherState> emit) async {
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      final weatherToPin = currentState.weatherList[event.index];
      final updatedWeatherList = List<Weather>.from(currentState.weatherList)
        ..removeAt(event.index)
        ..insert(0, weatherToPin);
      emit(WeatherLoaded(updatedWeatherList));
    }
  }
}
