import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:weather_app/blocs/weather_bloc/weather_bloc.dart';
import 'package:weather_app/model/enum.dart';
import 'package:weather_app/screens/cities_weather/screens/cities_weather_screen.dart';
import 'package:weather_app/screens/home/widgets/compass.dart';
import 'package:weather_app/screens/home/widgets/hourly_forecast_card.dart';
import 'package:weather_app/screens/home/widgets/uv_gauge.dart';
import 'package:weather_app/screens/home/widgets/weather_info_card.dart';
import 'package:weather_app/util/color_pallet.dart';
import 'package:weather_app/util/popup_handler.dart';
import 'package:weather_app/util/weather_utils.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late ScrollController _scrollController;
  final double _itemWidth = 60.w;


  Future<void> _onRefresh() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      print('Latitude : ${position.latitude}');
      print('Longitude: ${position.longitude}');
      context.read<WeatherBloc>().add(FetchWeatherByLocation(position: position));
      await Future.delayed(Duration(seconds: 1));

      Fluttertoast.showToast(
        msg: "Weather data refreshed successfully!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorPallet.black_opacity,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print('Error: $e');
      PopupHandler.showErrorDialog(context, message: e.toString());

      Fluttertoast.showToast(
        msg: "Failed to refresh weather data.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorPallet.black_opacity,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState(){
    super.initState();
    int currentHour = DateTime.now().hour;
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double initialScrollOffset = currentHour * _itemWidth;
      _scrollController.jumpTo(initialScrollOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: ColorPallet.gradientA_1,
        color: ColorPallet.blue,
        child: MultiBlocListener(
          listeners: [
            BlocListener<ConnectivityBloc, ConnectivityState>(
              listener: (context, connectivityState) {
                if (connectivityState.hasInternet) {
                  print('Internet connection restored!');
                  Fluttertoast.showToast(
                    msg: "Internet connection restored!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: ColorPallet.black_opacity,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  print('No internet connection.');
                  Fluttertoast.showToast(
                    msg: "No internet connection.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: ColorPallet.black_opacity,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
            ),
          ],
          child: Scaffold(
            body: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, weatherState) {
                String backgroundImage = 'assets/background/default.jpg';
                final hour = DateTime.now().hour;
                if (hour >= 6 && hour < 12) {
                  backgroundImage = 'assets/background/morning.jpg'; // Morning
                } else if (hour >= 12 && hour < 16) {
                  backgroundImage = 'assets/background/afternoon.jpg'; // Afternoon
                } else if (hour >= 16 && hour < 19) {
                  backgroundImage = 'assets/background/evening.jpg'; // Evening
                } else {
                  backgroundImage = 'assets/background/night.jpg'; // Night
                }

                if (weatherState.dataFetchStatus == DataFetchStatus.corrupted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    PopupHandler.showErrorDialog(
                      context,
                      message: 'Unable to fetch weather data. Please check your internet connection or try again later.',
                    );
                  });
                }

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      backgroundImage,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorPallet.gradientB_1.withOpacity(0.6),
                            ColorPallet.gradientB_2.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 60.h, bottom: 75.h),
                          child: Center(
                            child: Column(
                              children: [
                                Image.network(
                                  'https:${weatherState.weather.conditionIcon}',
                                  height: 64.h,
                                ),
                                Text(
                                  '${weatherState.weather.cityName}',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: ColorPallet.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${weatherState.weather.tempC} °C',
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    color: ColorPallet.white,
                                  ),
                                ),
                                Text(
                                  'Feels like ${weatherState.weather.feelsLikeC} °C',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ColorPallet.offWhite,
                                  ),
                                ),
                                Text(
                                  '${weatherState.weather.condition}',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorPallet.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
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
                                          ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Hourly Forecast',
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorPallet.offWhite,
                                                ),
                                              ),
                                              Text(
                                                weatherState.forecastDays[0].date,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorPallet.offWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 7.h),
                                          Container(
                                            height: 130.h,
                                            child: Scrollbar(
                                              thumbVisibility: true,
                                              trackVisibility: true,
                                              controller: _scrollController,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                controller: _scrollController,
                                                itemCount: weatherState.forecastDays.length,
                                                itemBuilder: (context, index) {
                                                  final forecastDay = weatherState.forecastDays[index];
                                                  return Row(
                                                    children: forecastDay.hourlyForecasts.map((hourlyForecast) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(right: 8.0.h, bottom: 10.0.h),
                                                        child: HourlyForecastCard(
                                                          time: formatTime(hourlyForecast.time),
                                                          iconUrl: hourlyForecast.conditionIcon,
                                                          temperature: hourlyForecast.tempC,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Container(
                                      height: 170.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
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
                                                  ]
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Wind Direction',
                                                    style: TextStyle(
                                                      fontSize: 16.h,
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorPallet.offWhite,
                                                    ),
                                                  ),
                                                  CompassWidget(windDirection: weatherState.weather.windDirection),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          WeatherInfoCard(
                                            title: 'Wind Speed',
                                            value: '${weatherState.weather.windKph} Km/h',
                                            description: getWindSpeedDescription(weatherState.weather.windKph),
                                            imagePath: 'assets/icon/wind.png',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Container(
                                      height: 170.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          WeatherInfoCard(
                                            title: 'Rainfall',
                                            value: '${weatherState.weather.precip_mm} mm',
                                            description: getRainfallDescription(weatherState.weather.precip_mm),
                                            imagePath: 'assets/icon/rainfall.png',
                                          ),
                                          SizedBox(width: 10.w),
                                          WeatherInfoCard(
                                            title: 'Visibility',
                                            value: '${weatherState.weather.visibility} km',
                                            description: getVisibilityDescription(weatherState.weather.visibility),
                                            imagePath: 'assets/icon/visibility.png',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height: 170.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          WeatherInfoCard(
                                            title: 'Humidity',
                                            value: '${weatherState.weather.humidity}%',
                                            description: getHumidityDescription(weatherState.weather.humidity),
                                            imagePath: 'assets/icon/humidity.png',
                                          ),
                                          SizedBox(width: 10.w),
                                          WeatherInfoCard(
                                            title: 'UV Index',
                                            value: '${weatherState.weather.uv}',
                                            description: getUVIndexDescription(weatherState.weather.uv),
                                            imagePath: 'assets/icon/uv_circle.png',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Container(
                                      height: 170.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          WeatherInfoCard(
                                            title: 'Cloud',
                                            value: '${weatherState.weather.cloud}%',
                                            description: getCloudCoverDescription(weatherState.weather.cloud),
                                            imagePath: 'assets/icon/cloud.png',
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CitiesWeatherScreen(),
                                                  ),
                                                );
                                              },
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
                                                      'View Weather for Other Cities',
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: ColorPallet.offWhite,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: ColorPallet.offWhite,
                                                      size: 32.sp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
