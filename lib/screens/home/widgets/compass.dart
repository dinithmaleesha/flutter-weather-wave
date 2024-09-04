import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/util/weather_utils.dart';

class CompassWidget extends StatefulWidget {
  final String windDirection;

  CompassWidget({required this.windDirection});

  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _currentAngle = 0;
  late double _targetAngle = 0;

  @override
  void initState() {
    super.initState();

    _currentAngle = 0.0;
    _targetAngle = getWindDirectionAngle(widget.windDirection);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: _currentAngle, end: _targetAngle).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CompassWidget oldWidget) {
    super.didUpdateWidget(oldWidget);


    if (oldWidget.windDirection != widget.windDirection) {
      setState(() {
        _currentAngle = _targetAngle;
        _targetAngle = getWindDirectionAngle(widget.windDirection);
        _animation = Tween<double>(begin: _currentAngle, end: _targetAngle).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        );
        _controller.forward(from: 0.0);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/icon/compass.png',
            height: 110.h,
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 30.h,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
