import 'package:flutter/foundation.dart';

class GenericWeather {
  String humidity;
  String pressure;
  String status;
  String temperature;
  String wind;

  GenericWeather({
    @required this.humidity,
    @required this.pressure,
    @required this.status,
    @required this.temperature,
    @required this.wind,
  });

  GenericWeather.emptyInitialize();

  GenericWeather.fromJson(Map<String, dynamic> current)
      : humidity = current['humidity'],
        pressure = current['pressure'],
        status = current['status'],
        temperature = current['temperature'],
        wind = current['wind'];
}