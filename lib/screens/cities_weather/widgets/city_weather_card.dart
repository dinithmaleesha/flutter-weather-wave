import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/util/color_pallet.dart';

class CityWeatherCard extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String icon;
  final String condition;
  final double feelsLikeC;


  const CityWeatherCard({
    Key? key,
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.feelsLikeC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        height: 122.h,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPallet.gradientA_1,
              ColorPallet.gradientA_2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temperature} °C',
                    style: TextStyle(
                      fontSize: 36.sp,
                      color: ColorPallet.white,
                    ),
                  ),
                  ClipOval(
                    child: Image.network(
                      'http:${icon}',
                      height: 50.h,
                      width: 50.w,
                      fit: BoxFit.cover,
                    ),
                  )

                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                children: [
                  Text(
                    'Feels like ${feelsLikeC} °C',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorPallet.offWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${cityName}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: ColorPallet.white,
                    ),
                  ),
                  Text(
                    '${condition}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: ColorPallet.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}