import 'package:weather_app/model/hourly_forecast.dart';

class ForecastDay {
  final String date;
  final double avgTempC;
  final String dayConditionIcon;
  final List<HourlyForecast> hourlyForecasts;

  ForecastDay({
    required this.date,
    required this.avgTempC,
    required this.dayConditionIcon,
    required this.hourlyForecasts,
  });

  ForecastDay copyWhit({
    String? date,
    double? avgTempC,
    String? dayConditionIcon,
    List<HourlyForecast>? hourlyForecasts,
  }) {
    return ForecastDay(
        date: date ?? this.date,
        avgTempC: avgTempC ?? this.avgTempC,
        dayConditionIcon: dayConditionIcon ?? this.dayConditionIcon,
        hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts
    );
  }

  factory ForecastDay.initial() {
    return ForecastDay(
      date: '',
      avgTempC: 0.0,
      dayConditionIcon: '',
      hourlyForecasts: [],
    );
  }

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    var hourlyList = json['hour'] as List;
    List<HourlyForecast> hourlyForecasts = hourlyList.map((i) => HourlyForecast.fromJson(i)).toList();

    return ForecastDay(
      date: json['date'],
      avgTempC: json['day']['avgtemp_c'],
      dayConditionIcon: json['day']['condition']['icon'],
      hourlyForecasts: hourlyForecasts,
    );
  }
}
