import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'dart:math';

class ChartPressHumDays extends StatelessWidget {
  final List<Day> days;
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  ChartPressHumDays(this.days);

  @override
  Widget build(BuildContext context) {
    List<int> pressures = [];
    List<int> humidity = [];

    days.forEach((day) {
      pressures.add(int.parse(day.weather.pressure.split(' ')[0]));
      humidity.add(int.parse(day.weather.humidity.split(' ')[0]));
    });

    int maxPressure = pressures.reduce(max) + 300;
    int maxHumidity = 100;


    return Card(
      elevation: 8,
      color: const Color(0xff2c4260),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: ListTile(
                      leading: Icon(Icons.crop_square, color: Colors.greenAccent),
                      title: Text(tr("web_chart_hum_title"), style: TextStyle(fontSize: 10, color: Colors.white))
                  )
              ),
              Expanded(
                  child: ListTile(
                      leading: Icon(Icons.crop_square, color: Colors.redAccent),
                      title: Text(tr("web_chart_press_title"), style: TextStyle(fontSize: 10, color: Colors.white))
                  )
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 35, left: 35, bottom: 20, top: 5),
              child: BarChart(
                chartData(pressures, humidity, maxPressure, maxHumidity)
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartData chartData(pressures, humidity, maxPressure, maxHumidity) {
    return BarChartData(
      maxY: 1,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              String pointVal;;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = days[0].day.toUpperCase();
                  pointVal = rodIndex == 0 ? '${pressures[0]} mbar' : '${humidity[0]} %';
                  break;
                case 1:
                  weekDay = days[1].day.toUpperCase();
                  pointVal = rodIndex == 0 ? '${pressures[1]} mbar' : '${humidity[1]} %';
                  break;
                case 2:
                  weekDay = days[2].day.toUpperCase();
                  pointVal = rodIndex == 0 ? '${pressures[2]} mbar' : '${humidity[2]} %';
                  break;
                case 3:
                  weekDay = days[3].day.toUpperCase();
                  pointVal = rodIndex == 0 ? '${pressures[3]} mbar' : '${humidity[3]} %';
                  break;
                case 4:
                  weekDay = days[4].day.toUpperCase();
                  pointVal = rodIndex == 0 ? '${pressures[4]} mbar' : '${humidity[4]} %';
                  break;
              }
              return BarTooltipItem(
                  weekDay + '\n' + pointVal, TextStyle(color: Colors.yellow, fontSize: 11));
            }),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: const Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return days[0].day.substring(0,3).toUpperCase();
              case 1:
                return days[1].day.substring(0,3).toUpperCase();
              case 2:
                return days[2].day.substring(0,3).toUpperCase();
              case 3:
                return days[3].day.substring(0,3).toUpperCase();
              case 4:
                return days[4].day.substring(0,3).toUpperCase();
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: [
        makeGroupData(0, (pressures[0] / maxPressure), (humidity[0] / maxHumidity)),
        makeGroupData(1, (pressures[1] / maxPressure), (humidity[1] / maxHumidity)),
        makeGroupData(2, (pressures[2] / maxPressure), (humidity[2] / maxHumidity)),
        makeGroupData(3, (pressures[3] / maxPressure), (humidity[3] / maxHumidity)),
        makeGroupData(4, (pressures[4] / maxPressure), (humidity[4] / maxHumidity)),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }


}
