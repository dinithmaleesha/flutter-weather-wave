import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/util/enum.dart';
import 'package:weather_app/model/forecast_day.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/services/api_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiService apiService;

  WeatherBloc({required this.apiService}) : super(WeatherState.initial()) {
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation);
  }

  Future<void> _onFetchWeatherByLocation(
      FetchWeatherByLocation event, Emitter<WeatherState> emit) async {
    print('Start Fetching Weather by Location');
    try {
      emit(state.copyWith(dataFetchStatus: DataFetchStatus.started));

      final weather = await apiService.fetchWeatherByLocation(
        event.position.latitude,
        event.position.longitude,
      );
      final forecastDay = await apiService.fetchForecastByLocation(
        event.position.latitude,
        event.position.longitude,
      );

      emit(state.copyWith(
        weather: weather,
        forecastDays: forecastDay,
        dataFetchStatus: DataFetchStatus.done,
      ));
      print('End Fetching Weather by Location');
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(dataFetchStatus: DataFetchStatus.corrupted));
      print('Corrupted Fetching Weather by Location');
    }
  }
}
