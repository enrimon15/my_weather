import 'package:flutter/foundation.dart';
import 'package:my_weather/models/generic_weather.dart';

class DayWeather {
  String cityHeight;
  String cityName;
  String cityProvince;
  List<Hour> hours;

  DayWeather({
    @required this.cityHeight,
    @required this.cityName,
    @required this.cityProvince,
    @required this.hours,
  });

  DayWeather.emptyInitialize();

  DayWeather.fromJson(Map<String, dynamic> json)
      : cityHeight = json['cityHeight'],
        cityName = json['cityName'],
        cityProvince = json['cityProvince'],
        hours = json['hours'] != null ? (json['hours'] as List).map((singleHour) => Hour.fromJson(singleHour)).toList() : null;
}


class Hour {
  String hour;
  GenericWeather weather;

  Hour({
    @required this.hour,
    @required this.weather,
  });

  Hour.emptyInitialize();

  Hour.fromJson(Map<String, dynamic> json)
      : hour = json['hour'],
        weather = json['weather'] != null ? GenericWeather.fromJson(json['weather']) : null;
}

