import 'package:flutter/material.dart';
import 'package:my_weather/pages/home/widgets/hours_item_widget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class HoursList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final hours = weatherProvider.getTodayWeather.hours; //list of hours

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 20, top: 0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return HourItem(hours[index]);
          },
          itemCount: hours.length,
        ),
      ),
    );
  }
}
