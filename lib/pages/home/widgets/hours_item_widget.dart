import 'package:flutter/material.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class HourItem extends StatelessWidget {
  final Hour hour;
  final DateTime now = new DateTime.now();

  HourItem(this.hour);

  @override
  Widget build(BuildContext context) {
    if (hour.hour.substring(0,2) == now.hour.toString()) {
      return NowHour(hour: hour);
    } else {
      return GenericHour(hour: hour);
    }
  }
}

class GenericHour extends StatelessWidget {
  const GenericHour({
    Key key,
    @required this.hour,
  }) : super(key: key);

  final Hour hour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            hour.hour.substring(0,2),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
          Image.asset(
            WeatherIcon.selectIcon(hour.weather.status),
            height: 34,
          ),
          Text(
            '${hour.weather.temperature.split(' ')[0]}°',
            style: TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}

class NowHour extends StatelessWidget {
  const NowHour({
    Key key,
    @required this.hour,
  }) : super(key: key);

  final Hour hour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(23),
                    bottom: Radius.circular(23)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius:2,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.symmetric(vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Ora',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset(
                    WeatherIcon.selectIcon(hour.weather.status),
                    //alignment: Alignment.bottomLeft,
                    height: 34,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
