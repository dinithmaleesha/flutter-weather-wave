// city_weather.dart

class CityWeather {
  final String cityName;
  final double temperature;
  final String icon;
  final String condition;
  final double feelsLikeC;

  CityWeather({
    required this.cityName,
    required this.temperature,
    required this.icon,
    required this.condition,
    required this.feelsLikeC,
  });

  factory CityWeather.initial() {
    return CityWeather(
      cityName: '',
      temperature: 0.0,
      icon: '',
      condition: '',
      feelsLikeC: 0.0,
    );
  }

  CityWeather copyWith({
    String? cityName,
    double? temperature,
    String? icon,
    String? condition,
    double? feelsLikeC,
  }) {
    return CityWeather(
      cityName: cityName ?? this.cityName,
      temperature: temperature ?? this.temperature,
      icon: icon ?? this.icon,
      condition: condition ?? this.condition,
      feelsLikeC: feelsLikeC ?? this.feelsLikeC,
    );
  }

  @override
  String toString() {
    return 'CityWeather(cityName: $cityName, temperature: $temperature°C, icon: $icon, condition: $condition, feelsLikeC: $feelsLikeC°C)';
  }

  factory CityWeather.fromJson(Map<String, dynamic> json) {
    return CityWeather(
      cityName: json['location']['name'],
      feelsLikeC: json['current']['feelslike_c'],
      condition: json['current']['condition']['text'],
      icon: json['current']['condition']['icon'],
      temperature: json['current']['temp_c'],
    );
  }
}
