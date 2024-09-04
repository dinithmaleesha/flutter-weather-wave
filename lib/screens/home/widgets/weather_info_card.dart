import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/util/color_pallet.dart';


class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;
  final String imagePath;

  const WeatherInfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ColorPallet.gradientA_1, ColorPallet.gradientA_2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorPallet.offWhite,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 26.sp,
                color: ColorPallet.white,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorPallet.offWhite,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 60.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
