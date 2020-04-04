import 'package:flutter/foundation.dart';
import 'package:my_weather/models/generic_weather.dart';

class FiveDaysWeather {
    String cityHeight;
    String cityName;
    String cityProvince;
    List<Day> days;

    FiveDaysWeather({
      @required this.cityHeight,
      @required this.cityName,
      @required this.cityProvince,
      @required this.days
    });

    FiveDaysWeather.emptyInitialize();

    FiveDaysWeather.fromJson(Map<String, dynamic> json)
         :  cityHeight = json['cityHeight'],
            cityName = json['cityName'],
            cityProvince = json['cityProvince'],
            days = json['days'] != null ? (json['days'] as List).map((i) => Day.fromJson(i)).toList() : null;

}

class Day {
    String day;
    GenericWeather weather;

    Day({
      @required this.day,
      @required this.weather
    });

    Day.emptyInitialize();

    Day.fromJson(Map<String, dynamic> json)
        :   day = json['day'],
            weather = json['weather'] != null ? GenericWeather.fromJson(json['weather']) : null;

}
