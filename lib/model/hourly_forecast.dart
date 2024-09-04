class HourlyForecast {
  final DateTime time;
  final double tempC;
  final String conditionIcon;

  HourlyForecast({
    required this.time,
    required this.tempC,
    required this.conditionIcon,
  });

  factory HourlyForecast.initial() {
    return HourlyForecast(
      time: DateTime.now(),
      tempC: 0.0,
      conditionIcon: '',
    );
  }

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.parse(json['time']),
      tempC: json['temp_c'],
      conditionIcon: json['condition']['icon'],
    );
  }

  HourlyForecast copyWith({
    DateTime? time,
    double? tempC,
    String? conditionIcon,
  }) {
    return HourlyForecast(
      time: time ?? this.time,
      tempC: tempC ?? this.tempC,
      conditionIcon: conditionIcon ?? this.conditionIcon,
    );
  }
}
