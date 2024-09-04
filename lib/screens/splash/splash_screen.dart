import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/blocs/app_bloc/app_bloc.dart';
import 'package:weather_app/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:weather_app/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_app/util/enum.dart';
import 'package:weather_app/screens/home/views/weather_page.dart';
import 'package:weather_app/util/color_pallet.dart';
import 'package:weather_app/util/popup_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectivityBloc>().add(ListenToConnectivityStatus());
  }

  Future<void> _fetchWeather() async {
    try {
      Position position = await _determinePosition();
      print('Latitude : ${position.latitude}');
      print('Longitude: ${position.longitude}');
      context.read<AppBloc>().add(ChangeSplashDataFetchText('Fetching Weather Data...'));
      context.read<WeatherBloc>().add(FetchWeatherByLocation(position: position));
    } catch (e) {
      print('Error: $e');
      PopupHandler.showErrorDialog(context, message: e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    context.read<AppBloc>().add(ChangeSplashDataFetchText('Fetching User Location...'));
    print('Check user location data');
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        await _showLocationDeniedDialog();
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      await _showLocationDeniedDialog();
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _showLocationDeniedDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: ColorPallet.offWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Row(
          children: [
            Icon(Icons.location_off, color: ColorPallet.blue),
            SizedBox(width: 8.w),
            Text('Location Permission Denied', style: TextStyle(color: ColorPallet.blue, fontSize: 20.sp)),
          ],
        ),
        content: Text(
          'To provide the best experience, the app needs access to your location. '
              'Please enable location permissions in the app settings.',
          style: TextStyle(color: ColorPallet.black_opacity, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Geolocator.openAppSettings();
            },
            style: TextButton.styleFrom(
              backgroundColor: ColorPallet.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Open Settings',
              style: TextStyle(color: ColorPallet.white),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.offWhite,
      body: MultiBlocListener(
        listeners: [
          BlocListener<WeatherBloc, WeatherState>(
            listener: (context, weatherState) async {
              if (weatherState.dataFetchStatus == DataFetchStatus.done) {
                await Future.delayed(Duration(seconds: 3));
                context.read<AppBloc>().add(ChangeSplashDataFetchText('Launching...'));
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => WeatherPage(),
                  ),
                );
              } else if (weatherState.dataFetchStatus == DataFetchStatus.corrupted) {
                PopupHandler.showErrorDialog(context, message: "Error Fetching Weather Data");
              }
            },
          ),
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, connectivityState) {
              if (connectivityState.hasInternet) {
                _fetchWeather();
              } else {
                context.read<AppBloc>().add(ChangeSplashDataFetchText('Waiting for internet connection...'));
              }
            },
          ),
        ],
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400.h,
                    child: Image.asset('assets/gif/splash_2.gif', fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
            BlocBuilder<AppBloc, AppState>(
              builder: (context, appState) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Text(appState.splashText ?? ''),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
