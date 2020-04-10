import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/models/generic_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class Header extends StatelessWidget {
  final String cityName;
  final GenericWeather currentWeather;

  Header({
    @required this.cityName,
    @required this.currentWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currentWeather.temperature.substring(0,2) + '°',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 70
                ),
              ),
              SizedBox(height: 5),
              Text(
                cityName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20
                ),
              )
            ],
          ),
          Image.asset(
            WeatherIcon.selectIcon(currentWeather.status),
            height: 80,
          ),
        ],
      ),
    );
  }
}
