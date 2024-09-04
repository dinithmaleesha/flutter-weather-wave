import 'dart:math';

import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('HH:mm');
  return formatter.format(dateTime);
}

double getWindDirectionAngle(String abbreviation) {
  switch (abbreviation) {
    case 'N':
      return 0; // 0 degrees
    case 'NNE':
      return pi / 8; // 22.5 degrees
    case 'NE':
      return pi / 4; // 45 degrees
    case 'ENE':
      return 3 * pi / 8; // 67.5 degrees
    case 'E':
      return pi / 2; // 90 degrees
    case 'ESE':
      return 5 * pi / 8; // 112.5 degrees
    case 'SE':
      return 3 * pi / 4; // 135 degrees
    case 'SSE':
      return 7 * pi / 8; // 157.5 degrees
    case 'S':
      return pi; // 180 degrees
    case 'SSW':
      return 9 * pi / 8; // 202.5 degrees
    case 'SW':
      return 5 * pi / 4; // 225 degrees
    case 'WSW':
      return 11 * pi / 8; // 247.5 degrees
    case 'W':
      return 3 * pi / 2; // 270 degrees
    case 'WNW':
      return 13 * pi / 8; // 292.5 degrees
    case 'NW':
      return 7 * pi / 4; // 315 degrees
    case 'NNW':
      return 15 * pi / 8; // 337.5 degrees
    default:
      return 0; // Default to 0 degrees if not found
  }
}

String getWindSpeedDescription(double windSpeed) {
  if (windSpeed < 10) {
    return 'Light breeze';
  } else if (windSpeed < 30) {
    return 'Moderate wind';
  } else if (windSpeed < 50) {
    return 'Strong wind';
  } else {
    return 'Very strong wind';
  }
}

String getRainfallDescription(double precipMm) {
  if (precipMm == 0) {
    return 'No precipitation';
  } else if (precipMm < 2) {
    return 'Light rain or drizzle';
  } else if (precipMm < 10) {
    return 'Moderate rain';
  } else if (precipMm < 30) {
    return 'Heavy rain';
  } else {
    return 'Very heavy rain';
  }
}

String getVisibilityDescription(double visibilityKm) {
  if (visibilityKm >= 10) {
    return 'Visibility is excellent';
  } else if (visibilityKm >= 5) {
    return 'Visibility is good';
  } else if (visibilityKm >= 2) {
    return 'Visibility is moderate';
  } else if (visibilityKm >= 0.5) {
    return 'Visibility is poor';
  } else {
    return 'Visibility is very poor';
  }
}

String getHumidityDescription(int humidity) {
  if (humidity <= 30) {
    return 'Dry air';
  } else if (humidity <= 60) {
    return 'Comfortable';
  } else if (humidity <= 80) {
    return 'Muggy air';
  } else {
    return 'Very humid';
  }
}

String getUVIndexDescription(double uvIndex) {
  if (uvIndex <= 3) {
    return 'Low UV';
  } else if (uvIndex <= 6) {
    return 'Moderate UV';
  } else if (uvIndex <= 9) {
    return 'High UV';
  }  else {
    return 'Very High UV';
  }
}

String getCloudCoverDescription(int cloudCover) {
  if (cloudCover == 0) {
    return 'Clear sky';
  } else if (cloudCover <= 25) {
    return 'Mostly clear';
  } else if (cloudCover <= 50) {
    return 'Partly cloudy';
  } else if (cloudCover <= 75) {
    return 'Mostly cloudy';
  } else if (cloudCover < 100) {
    return 'Overcast or nearly overcast.';
  } else {
    return 'Fully overcast';
  }
}
