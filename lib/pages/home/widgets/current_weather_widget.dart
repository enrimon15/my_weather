import 'package:flutter/material.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CurrentWeather extends StatelessWidget {

  final DateTime now = new DateTime.now();
  final locale = 'it_IT';

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final currentWeather = weatherProvider.getCurrentWeather;

    return Container(
      padding: EdgeInsets.all(40),
      width: double.infinity,
      height: 430,
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                //'L\' Aquila,',
                weatherProvider.getTodayWeather.cityName + ',',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(width: 20,),
              Text(
                currentWeather.temperature.substring(0,2) + '°',
                //'18°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Text(
            //'Domenica 6',
            '${DateFormat.EEEE(locale).format(DateTime.now())} ${now.day}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 30,),
          Image.asset(
            WeatherIcon.selectIcon(currentWeather.status),
            height: 105,
          ),
          SizedBox(height: 30,),
          Text(
            //'Cielo Coperto',
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
}
