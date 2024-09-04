part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  final Weather weather;
  final List<ForecastDay> forecastDays;
  final Position? position;
  final DataFetchStatus dataFetchStatus;

  WeatherState({
    required this.weather,
    required this.forecastDays,
    this.position,
    required this.dataFetchStatus
  });

  factory WeatherState.initial() {
    return WeatherState(
      weather: Weather.initial(),
      forecastDays: [],
      dataFetchStatus: DataFetchStatus.initial,
    );
  }

  WeatherState copyWith({
    Weather? weather,
    List<ForecastDay>? forecastDays,
    Position? position,
    DataFetchStatus? dataFetchStatus,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      forecastDays: forecastDays ?? this.forecastDays,
      position: position ?? this.position,
      dataFetchStatus: dataFetchStatus ?? this.dataFetchStatus,
    );
  }

  @override
  List<Object?> get props => [
    weather,
    forecastDays,
    position,
    dataFetchStatus
  ];
}