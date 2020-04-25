import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'dart:math';

class ChartWindDays extends StatelessWidget {
  final List<Day> days;
  
  ChartWindDays(this.days);
  
  @override
  Widget build(BuildContext context) {
    List<int> wind = [];
    days.forEach((day) { 
      wind.add(int.parse(day.weather.wind.split(' ')[0]));
    });
    int maxWind = wind.reduce(max) + 5;
    int range = (maxWind/4).round();
    
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(20),
        child: LineChart(
          chartData(wind, maxWind, range),
        ),
      ),
    );
  }

  LineChartData chartData(values, maxWind, range) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          margin: 6,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return days[0].day.substring(0,3).toUpperCase();
              case 2:
                return days[1].day.substring(0,3).toUpperCase();
              case 3:
                return days[2].day.substring(0,3).toUpperCase();
              case 4:
                return days[3].day.substring(0,3).toUpperCase();
              case 5:
                return days[4].day.substring(0,3).toUpperCase();
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return (range).toString();
              case 2:
                return (range * 2).toString();
              case 3:
                return (range * 3).toString();
              case 4:
                return (range * 4).toString(); //max
            }
            return '';
          },
          margin: 3,
          reservedSize: 20,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          )),
      minX: 0,
      maxX: 6,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData2(values, maxWind),
    );
  }

  List<LineChartBarData> linesBarData2(values, maxWind) {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, 3.8),
          FlSpot(2, 1.5),
          FlSpot(3, 1.9),
        ],
        isCurved: true,
        curveSmoothness: 0,
        colors: const [
          Color(0x4427b6fc),
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }
}
