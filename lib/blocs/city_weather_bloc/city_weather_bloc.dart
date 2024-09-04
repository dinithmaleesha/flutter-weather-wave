import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/model/enum.dart';
import 'package:weather_app/services/api_service.dart';

part 'city_weather_event.dart';
part 'city_weather_state.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final ApiService apiService;

  CityWeatherBloc({required this.apiService}) : super(CityWeatherState.initial()) {
    on<FetchMultipleCitiesWeather>(_onFetchMultipleCitiesWeather);
  }


  Future<void> _onFetchMultipleCitiesWeather(
      FetchMultipleCitiesWeather event, Emitter<CityWeatherState> emit) async {
    print('Start Fetching Multiple Cities Weather');
    try {
      emit(state.copyWith(isLoading: true, dataFetchStatus: DataFetchStatus.started));

      final weatherList = await apiService.fetchMultipleCitiesWeather(event.cities);

      emit(state.copyWith(
        cityWeather: weatherList,
        isLoading: false,
        dataFetchStatus: DataFetchStatus.done,
      ));
      print('End Fetching Multiple Cities Weather');
    } catch (error) {
      print('Error: $error');
      emit(state.copyWith(isLoading: false, dataFetchStatus: DataFetchStatus.corrupted));
      print('Corrupted Fetching Multiple Cities Weather');
    }
  }
}
