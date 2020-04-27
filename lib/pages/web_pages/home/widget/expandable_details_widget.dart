import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/models/generic_weather.dart';

class ExpandableDetails extends StatelessWidget {
  final Day tappedDay;
  final GenericWeather defaultWeather;

  ExpandableDetails(this.tappedDay, this.defaultWeather);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 200,
          alignment: Alignment.center,
          child: ListTile(
            title: Text(tr("details_wind").toUpperCase()),
            subtitle: tappedDay != null ? Text(tappedDay.weather.wind) : Text(defaultWeather.wind),
            leading: Image.asset('assets/img/wind.png', height: 40),
          ),
        ),
        Container(
          width: 200,
          child: ListTile(
            title: Text(tr("details_humidity").toUpperCase()),
            subtitle: tappedDay != null ? Text(tappedDay.weather.humidity) : Text(defaultWeather.humidity),
            leading: Image.asset('assets/img/drop.png', height: 40),
          ),
        ),
        Container(
          width: 200,
          child: ListTile(
            title: Text(tr("details_pressure").toUpperCase()),
            subtitle: tappedDay != null ? Text(tappedDay.weather.pressure) : Text(defaultWeather.pressure),
            leading: Image.asset('assets/img/speedometer.png', height: 40),
          ),
        ),
      ],
    );
  }
}
