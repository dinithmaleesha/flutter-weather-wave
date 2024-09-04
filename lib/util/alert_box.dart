import 'package:flutter/material.dart';
import 'package:weather_app/util/color_pallet.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.build,
            color: ColorPallet.offWhite,
            size: 60,
          ),
          SizedBox(height: 20),
          Text(
            "We're working on something exciting!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Thank you for your patience. This feature is currently under development and will be available soon.\nStay tuned for updates!",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
