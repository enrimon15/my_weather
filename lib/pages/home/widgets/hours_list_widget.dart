import 'package:flutter/material.dart';
import 'package:my_weather/pages/home/widgets/hours_item_widget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class HoursList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final hours = weatherProvider.getTodayWeather.hours; //list of hours
    final hoursNextDay = weatherProvider.getChartData.hours; //list of hour from now to the same hour of next day

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20, top: 0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return hours.length > 9
                ? HourItem(hours[index].hour, hours[index].weather.temperature, hours[index].weather.status)
                : HourItem(hoursNextDay[index].hour, hoursNextDay[index].temperature, hoursNextDay[index].status);
          },
            itemCount: hours.length > 9 ? hours.length : hoursNextDay.length,
        ),
      ),
    );
  }
}
