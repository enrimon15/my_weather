import 'package:flutter/material.dart';
import 'package:my_weather/pages/details/widgets/chart_temp_days_widget.dart';
import 'package:my_weather/pages/details/widgets/details_card_widget.dart';
import 'package:my_weather/pages/details/widgets/header_widget.dart';
import 'package:my_weather/pages/details/widgets/next_five_days_widget.dart';
import 'package:my_weather/pages/details/widgets/temperature_card_widget.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todayWeather = Provider.of<TodayWeather>(context);
    final nextDaysProvider = Provider.of<NextFiveDaysWeather>(context);
    final nextDaysWeather = nextDaysProvider.getFiveDaysWeather;

    return Column(
      children: <Widget>[
        Header(
          cityName: nextDaysWeather.cityName + ', ' + nextDaysWeather.cityProvince,
          currentWeather: todayWeather.getCurrentWeather,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              TempCard(todayWeather.getMinMaxTemp()),
              const SizedBox(height: 25),
              DetailsCard(todayWeather.getCurrentWeather),
              const SizedBox(height: 30),
              NextFiveDays(nextDaysWeather.days),
              const SizedBox(height: 35),
              ChartTempDays(nextDaysWeather.days),
              const SizedBox(height: 60),
            ],
          ),
        )
      ],
    );
  }
}
