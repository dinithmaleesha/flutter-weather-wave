part of 'city_weather_bloc.dart';

class CityWeatherState extends Equatable {
  final List<CityWeather> cityWeather;
  final bool isLoading;
  final DataFetchStatus dataFetchStatus;

  CityWeatherState({
    required this.cityWeather,
    required this.isLoading,
    required this.dataFetchStatus,
  });

  factory CityWeatherState.initial() {
    return CityWeatherState(
      cityWeather: [],
      isLoading: false,
      dataFetchStatus: DataFetchStatus.initial,
    );
  }

  CityWeatherState copyWith({
    List<CityWeather>? cityWeather,
    bool? isLoading,
    DataFetchStatus? dataFetchStatus,
  }) {
    return CityWeatherState(
      cityWeather: cityWeather ?? this.cityWeather,
      isLoading: isLoading ?? this.isLoading,
      dataFetchStatus: dataFetchStatus ?? this.dataFetchStatus,
    );
  }

  @override
  List<Object?> get props => [
    cityWeather,
    isLoading,
    dataFetchStatus,
  ];
}
