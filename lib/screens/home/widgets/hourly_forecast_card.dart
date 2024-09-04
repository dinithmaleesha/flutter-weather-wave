import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/util/color_pallet.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String iconUrl;
  final double temperature;

  const HourlyForecastCard({
    Key? key,
    required this.time,
    required this.iconUrl,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecastHour = int.tryParse(time.split(':')[0]) ?? 0;
    final currentHour = DateTime.now().hour;

    final isCurrentHour = forecastHour == currentHour;

    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150,
      width: 60.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorPallet.gradientB_1, ColorPallet.gradientB_2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        border: isCurrentHour
            ? Border.all(
          color: ColorPallet.blue,
          width: 1.0,
        )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10.0),
          Text(
            isCurrentHour? 'Now' : time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacer(),
          Image.network(
            'https:$iconUrl',
            width: 50.0.w,
            height: 50.0.h,
          ),
          Spacer(),
          Text(
            '${temperature.toStringAsFixed(1)}°C',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
