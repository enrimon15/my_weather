import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {

  final DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    final intlLocale = EasyLocalization.of(context).locale.toString();
    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final currentWeather = weatherProvider.getCurrentWeather;
    final mediaQuery = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: 75),
      width: double.infinity,
      height: (mediaQuery.size.height - CustomAppBar.height - mediaQuery.padding.top) * 0.72,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildHeader(
              weatherProvider.getTodayWeather.cityName + ',',
              currentWeather.temperature.split(' ')[0] + '°',
              '${DateFormat.EEEE(intlLocale).format(DateTime.now())} ${now.day}'
          ),
          //SizedBox(height: 30,),
          Image.asset(
            WeatherIcon.selectIcon(currentWeather.status),
            height: 105,
          ),
          //SizedBox(height: 30,),
          Text(
            currentWeather.status,
            style: TextStyle(
              letterSpacing: 8,
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(String city, String temp, String date) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              city,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(width: 20,),
            Text(
              temp,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        Text(
          date,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
