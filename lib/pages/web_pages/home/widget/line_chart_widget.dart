import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/day_weather.dart';
import 'dart:math';

class LineChartGraph extends StatelessWidget {
  final List<Hour> hours;

  LineChartGraph(this.hours);

  List<int> _getValues() {
    List<int> values = [];
    hours.map((singleHour) {
      int value = int.parse(singleHour.weather.temperature.split(' ')[0]);
      values.add(value);
    }).toList();
    return values;
  }

  @override
  Widget build(BuildContext context) {
    final values = _getValues();
    final maxVal = values.reduce(max);
    final range = ((maxVal + 10) / 4).round();
    final maxY = range * 4;

    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(20),
        child: LineChart(
          sampleData2(values, range, maxY),
        ),
      ),
    );
  }

  LineChartData sampleData2(values, range, maxY) {
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
          margin: 5,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '00';
              case 7:
                return '06';
              case 13:
                return '12';
              case 19:
                return '18';
              case 24:
                return '23';
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
                return range.toString();
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
      maxX: 25,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData2(values, maxY),
    );
  }

  List<LineChartBarData> linesBarData2(values, maxY) {
    return [
      LineChartBarData(
        spots: [
          FlSpot(1, (values[0] / maxY) * 4),
          FlSpot(4, (values[3] / maxY) * 4),
          FlSpot(7, (values[6] / maxY) * 4),
          FlSpot(10, (values[9] / maxY) * 4),
          FlSpot(13, (values[12] / maxY) * 4),
          FlSpot(16, (values[15] / maxY) * 4),
          FlSpot(19, (values[18] / maxY) * 4),
          FlSpot(22, (values[21] / maxY) * 4),
          FlSpot(24, (values[23] / maxY) * 4),
        ],
        isCurved: true,
        colors: const [
          Color(0x99aa4cfc),
        ],
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          const Color(0x33aa4cfc),
        ]),
      ),
    ];
  }

}
