import 'package:flutter/foundation.dart';

class ChartData {
    String cityName;
    String cityProvince;
    List<HourChart> hours;

    ChartData({
      @required this.cityName,
      @required this.cityProvince,
      @required this.hours
    });

    ChartData.emptyInitialize();

    ChartData.fromJson(Map<String, dynamic> json)
        :   cityName = json['cityName'],
            cityProvince = json['cityProvince'],
            hours = json['hours'] != null ? (json['hours'] as List).map((singleHour) => HourChart.fromJson(singleHour)).toList() : null;
}

class HourChart {
    String day;
    String hour;
    String temperature;
    String status;

    HourChart({
      @required this.day,
      @required this.hour,
      @required this.temperature
    });

    HourChart.fromJson(Map<String, dynamic> json)
        :   day = json['day'],
            hour = json['hour'],
            temperature = json['temperature'],
            status = json['status'];
}