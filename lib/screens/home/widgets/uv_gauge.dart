import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/util/color_pallet.dart';

class UvGauge extends StatefulWidget {
  final int uv; // UV index value between 0 and 10
  const UvGauge({
    super.key,
    required this.uv,
  });

  @override
  State<UvGauge> createState() => _UvGaugeState();
}

class _UvGaugeState extends State<UvGauge> {
  double _calculateRotationAngle(int uv) {
    // UV value 0 -> 270 degrees (3 * pi / 2 radians)
    // UV value 5 -> 0 degrees (0 radians)
    // UV value 10 -> 90 degrees (pi / 2 radians)

    double startAngle = 3 * pi / 2; // 270
    double midAngle = 0; // 0
    double endAngle = pi / 2; // 90

    if (uv <= 5) {
      return startAngle - (uv / 5) * startAngle;
    } else {
      return midAngle + ((uv - 5) / 5) * endAngle;
    }
  }

  @override
  Widget build(BuildContext context) {
    double rotationAngle = _calculateRotationAngle(widget.uv);
    //print('Rotation angle: $rotationAngle');

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/icon/uv_circle.png',
          height: 60.h,
        ),
        Positioned(
          top: 30.h,
          child: Transform.rotate(
            angle: 0.0, /// TODO
            child: const Icon(
              Icons.navigation,
              color: ColorPallet.offWhite,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
