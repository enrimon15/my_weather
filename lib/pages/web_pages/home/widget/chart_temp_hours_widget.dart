import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class ChartTempHours extends StatelessWidget {
  final List<Hour> hours;

  ChartTempHours(this.hours);

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
    final range = ((maxVal + 5) / 4).round();
    final maxY = (range * 4);
    final minmax = Provider.of<TodayWeather>(context).getMinMaxTemp();

    return Card(
      elevation: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(tr("web_chart_temp_title"), style: TextStyle(color: Color(0xff72719b), fontSize: 12)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: LineChart(
                chartData(values, range, maxY,minmax),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData chartData(values, range, maxY, minmax) {
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
                return minmax['min'].toString();
              case 1:
                return (minmax['min'] + range).toString();
              case 2:
                return (minmax['min'] + (range * 2)).toString();
              case 3:
                return (minmax['min'] + (range * 3)).toString();
              case 4:
                return (minmax['min'] + (range * 4)).toString(); //max
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
      lineBarsData: linesBarData2(values, maxY, minmax),
    );
  }

  List<LineChartBarData> linesBarData2(values, maxY, minmax) {
    final traslate = (minmax['min'] / maxY) * 4;

    double _getPoint(value) {
      return ((value / maxY) * 4) - traslate;
    }

    return [
      LineChartBarData(
        spots: [
          FlSpot(1, _getPoint(values[0])),
          FlSpot(4, _getPoint(values[3])),
          FlSpot(7, _getPoint(values[6])),
          FlSpot(10, _getPoint(values[9])),
          FlSpot(13, _getPoint(values[12])),
          FlSpot(16, _getPoint(values[15])),
          FlSpot(19, _getPoint(values[18])),
          FlSpot(22, _getPoint(values[21])),
          FlSpot(24, _getPoint(values[23])),
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