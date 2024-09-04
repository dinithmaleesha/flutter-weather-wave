import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/blocs/city_weather_bloc/city_weather_bloc.dart';
import 'package:weather_app/model/enum.dart';
import 'package:weather_app/screens/cities_weather/widgets/city_weather_card.dart';
import 'package:weather_app/util/color_pallet.dart';

class CitiesWeatherScreen extends StatefulWidget {
  @override
  State<CitiesWeatherScreen> createState() => _CitiesWeatherScreenState();
}

class _CitiesWeatherScreenState extends State<CitiesWeatherScreen> {
  @override
  void initState() {
    super.initState();
    _refreshWeather();
  }

  Future<void> _refreshWeather() async {
    context.read<CityWeatherBloc>().add(FetchMultipleCitiesWeather(cities: [
      'Kandy',
      'Galle',
      'Jaffna',
      'Anuradhapura',
      'Nuwara Eliya',
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorPallet.gradientB_1, ColorPallet.gradientB_2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: _refreshWeather,
            backgroundColor: ColorPallet.gradientA_1,
            color: ColorPallet.blue,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 10, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Weather',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CityWeatherBloc, CityWeatherState>(
                    builder: (context, cityWeatherState) {
                      if (cityWeatherState.dataFetchStatus == DataFetchStatus.started) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ColorPallet.gradientA_1,
                          ),
                        );
                      }

                      if (cityWeatherState.dataFetchStatus == DataFetchStatus.corrupted) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: ColorPallet.offWhite,
                                size: 60,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Failed to load weather data.",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPallet.white
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Please try again later.",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: ColorPallet.offWhite
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                onPressed: _refreshWeather,
                                child: Text("Retry",
                                style: TextStyle(
                                  color: ColorPallet.white
                                ),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorPallet.gradientA_1,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: cityWeatherState.cityWeather.length,
                        itemBuilder: (context, index) {
                          final weather = cityWeatherState.cityWeather[index];
                          return CityWeatherCard(
                            cityName: weather.cityName,
                            temperature: weather.temperature,
                            condition: weather.condition,
                            icon: weather.icon,
                            feelsLikeC: weather.feelsLikeC,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
