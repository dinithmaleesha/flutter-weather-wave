part of 'city_weather_bloc.dart';

@immutable
abstract class CityWeatherEvent {}

class FetchMultipleCitiesWeather  extends CityWeatherEvent {
  final List<String> cities;
  FetchMultipleCitiesWeather({required this.cities});
}