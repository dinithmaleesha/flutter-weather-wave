import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/model/city_weather.dart';
import 'package:weather_app/model/forecast_day.dart';
import 'package:weather_app/model/weather.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final apiKey = dotenv.env['APIKEY']; // Add your API key in the .env file with the key 'APIKEY'.

  Future<Weather> fetchWeatherByLocation(double latitude, double longitude) async{
    print("fetchWeatherByLocation");
    final url = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude,$longitude&aqi=no';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      print("fetchWeatherByLocation Done");
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  Future<List<ForecastDay>> fetchForecastByLocation(double latitude, double longitude) async {
    print("fetchForecastByLocation");
    final url = 'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=1&aqi=no&alerts=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("fetchForecastByLocation Done");
      final json = jsonDecode(response.body);
      final forecastDaysJson = json['forecast']['forecastday'] as List;

      return forecastDaysJson.map((dayJson) => ForecastDay.fromJson(dayJson)).toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  Future<CityWeather> fetchCityWeather(String city) async {
    print("fetchCityWeather");
    final url = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("fetchWeatherByLocation Done");
      final json = jsonDecode(response.body);
      return CityWeather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<CityWeather>> fetchMultipleCitiesWeather(List<String> cities) async {
    List<CityWeather> cityWeatherList = [];
    for (String city in cities) {
      try {
        final cityWeather = await fetchCityWeather(city);
        cityWeatherList.add(cityWeather);
      } catch (e) {
        print('Error fetching weather for $city: $e');
      }
    }
    return cityWeatherList;
  }

}