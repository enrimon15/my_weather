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
    final currentDayWeather = Provider.of<TodayWeather>(context).getCurrentWeather;
    final nextDaysProvider = Provider.of<NextFiveDaysWeather>(context);
    final nextDaysWeather = nextDaysProvider.getFiveDaysWeather;

    return Column(
      children: <Widget>[
        Header(
          cityName: nextDaysWeather.cityName + ', ' + nextDaysWeather.cityProvince,
          currentWeather: currentDayWeather,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: <Widget>[
              TempCard(),
              SizedBox(height: 25),
              DetailsCard(currentDayWeather),
              SizedBox(height: 30),
              NextFiveDays(nextDaysWeather.days),
              SizedBox(height: 35),
              ChartTempDays(nextDaysWeather.days),
              SizedBox(height: 60),
            ],
          ),
        )
      ],
    );
  }
}
