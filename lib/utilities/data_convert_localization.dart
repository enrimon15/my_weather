import 'package:flutter/cupertino.dart';

class ConvertLocalization {
  static String getTemperature(String temperatureServer) {
    int tempCelsius = int.parse(temperatureServer);
    int tempfahrenheit = ((tempCelsius * 9/5) + 32).toInt();
  }
}