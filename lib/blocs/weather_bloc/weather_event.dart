part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FetchWeatherByLocation extends WeatherEvent {
  final Position position;
  FetchWeatherByLocation({required this.position});
}
