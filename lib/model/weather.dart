class Weather {
  final String cityName;
  final String country;
  final double tempC;
  final double feelsLikeC;
  final String condition;
  final String conditionIcon;
  final double windKph;
  final String windDirection;
  final double pressure;
  final int humidity;
  final int cloud;
  final double visibility;
  final double uv;
  final double precip_mm;

  Weather({
    required this.cityName,
    required this.country,
    required this.tempC,
    required this.feelsLikeC,
    required this.condition,
    required this.conditionIcon,
    required this.windKph,
    required this.windDirection,
    required this.pressure,
    required this.humidity,
    required this.cloud,
    required this.visibility,
    required this.uv,
    required this.precip_mm,
  });

  Weather copyWith({
    String? cityName,
    String? country,
    double? tempC,
    double? feelsLikeC,
    String? condition,
    String? conditionIcon,
    double? windKph,
    String? windDirection,
    double? pressure,
    int? humidity,
    int? cloud,
    double? visibility,
    double? uv,
    double? precip_mm,
  }) {
    return Weather(
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      tempC: tempC ?? this.tempC,
      feelsLikeC: feelsLikeC ?? this.feelsLikeC,
      condition: condition ?? this.condition,
      conditionIcon: conditionIcon ?? this.conditionIcon,
      windKph: windKph ?? this.windKph,
      windDirection: windDirection ?? this.windDirection,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      cloud: cloud ?? this.cloud,
      visibility: visibility ?? this.visibility,
      uv: uv ?? this.uv,
      precip_mm: precip_mm ?? this.precip_mm,
    );
  }

  factory Weather.initial(){
    return Weather(
      cityName: '',
      country: '',
      tempC: 0.0,
      feelsLikeC: 0.0,
      condition: '',
      conditionIcon: '',
      windKph: 0.0,
      windDirection: '',
      pressure: 0.0,
      humidity: 0,
      cloud: 0,
      visibility: 0.0,
      uv: 0.0,
      precip_mm: 0.0
    );
  }

  @override
  String print() {
    return 'Weather Details:\n'
        'City: $cityName\n'
        'Country: $country\n'
        'Temperature (°C): $tempC\n'
        'Feels Like (°C): $feelsLikeC\n'
        'Condition: $condition\n'
        'Condition Icon: $conditionIcon\n'
        'Wind Speed (kph): $windKph\n'
        'Wind Direction: $windDirection\n'
        'Pressure: $pressure\n'
        'Humidity: $humidity%\n'
        'Cloud: $cloud%\n'
        'Visibility: $visibility km\n'
        'UV Index: $uv\n'
        'Precipitation (mm): $precip_mm';
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['location']['name'],
      country: json['location']['country'],
      tempC: json['current']['temp_c'],
      feelsLikeC: json['current']['feelslike_c'],
      condition: json['current']['condition']['text'],
      conditionIcon: json['current']['condition']['icon'],
      windKph: json['current']['wind_kph'],
      windDirection: json['current']['wind_dir'],
      pressure: json['current']['pressure_mb'],
      humidity: json['current']['humidity'],
      cloud: json['current']['cloud'],
      visibility: json['current']['vis_km'],
      uv: json['current']['uv'],
      precip_mm: json['current']['precip_mm'],
    );
  }
}
