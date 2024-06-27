import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String city;

  const FetchWeather(this.city);

  @override
  List<Object> get props => [city];
}

class AddCity extends WeatherEvent {
  final String city;

  const AddCity(this.city);

  @override
  List<Object> get props => [city];
}

class DeleteCity extends WeatherEvent {
  final int index;

  const DeleteCity(this.index);

  @override
  List<Object> get props => [index];
}

class PinCity extends WeatherEvent {
  final int index;

  const PinCity(this.index);

  @override
  List<Object> get props => [index];
}
