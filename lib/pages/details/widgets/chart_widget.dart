import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/pages/details/widgets/chart_bar_widget.dart';
import "dart:math";

class Chart extends StatelessWidget {
  final List<Day> days;

  Chart(this.days);

  double getMaxValue() {
    List<double> values = [];
    days.map((singleDay) {
      double value = double.parse(singleDay.weather.temperature.substring(0,2));
      values.add(value);
    }).toList();
    return values.reduce(max) + 5;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days.map((day) {
            String temp = day.weather.temperature.substring(0,2);
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  day.day.split(" ")[0],
                  temp,
                  (double.parse(temp)) / getMaxValue(),
              ),
            );
          }).toList(),
        ),
      ),
    );;
  }
}
