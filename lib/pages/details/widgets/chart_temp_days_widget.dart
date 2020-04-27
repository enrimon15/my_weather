import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/pages/details/widgets/chart_bar_widget.dart';
import "dart:math";

class ChartTempDays extends StatelessWidget {
  final List<Day> days;

  ChartTempDays(this.days);

  double _getMaxValue() {
    List<double> values = [];
    days.map((singleDay) {
      double value = double.parse(singleDay.weather.temperature.split(' ')[0]);
      values.add(value);
    }).toList();
    return values.reduce(max) + 5;
  }

  @override
  Widget build(BuildContext context) {
    double _maxValue = _getMaxValue();

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days.map((day) {
              String temp = day.weather.temperature.split(' ')[0];

              double tempDouble = double.parse(temp);
              if (tempDouble < 0) {
                tempDouble = 0 - tempDouble;
                _maxValue += tempDouble;
              }

              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    day.day.split(" ")[0],
                    temp,
                    (tempDouble) / _maxValue,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );;
  }
}
