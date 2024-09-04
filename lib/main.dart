import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/blocs/app_bloc/app_bloc.dart';
import 'package:weather_app/blocs/city_weather_bloc/city_weather_bloc.dart';
import 'package:weather_app/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:weather_app/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_app/screens/splash/splash_screen.dart';
import 'package:weather_app/services/api_service.dart';


void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(create: (context) => AppBloc()),
        BlocProvider<ConnectivityBloc>(create: (context) => ConnectivityBloc()),
        BlocProvider<WeatherBloc>(create: (context) => WeatherBloc(apiService: ApiService())),
        BlocProvider<CityWeatherBloc>(create: (context) => CityWeatherBloc(apiService: ApiService())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: SplashScreen(),
        );
      },
    );
  }
}
