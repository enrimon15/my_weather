import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/generic_weather.dart';

import 'current_details_card_widget.dart';

class CardDetails extends StatelessWidget {
  final GenericWeather currentWeather;

  CardDetails(this.currentWeather);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, sizingInformation) {
        if (sizingInformation.maxWidth > 980) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CurrentDetails(tr("details_wind").toUpperCase(), currentWeather.wind, 'assets/img/drop.png', 280),
              CurrentDetails(tr("details_pressure").toUpperCase(), currentWeather.pressure, 'assets/img/speedometer.png', 280),
              CurrentDetails(tr("details_humidity").toUpperCase(), currentWeather.humidity, 'assets/img/drop.png', 280),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CurrentDetails(tr("details_wind").toUpperCase(), currentWeather.wind, 'assets/img/drop.png', 600),
              const SizedBox(height: 20),
              CurrentDetails(tr("details_pressure").toUpperCase(), currentWeather.pressure, 'assets/img/speedometer.png', 600),
              const SizedBox(height: 20),
              CurrentDetails(tr("details_humidity").toUpperCase(), currentWeather.humidity, 'assets/img/drop.png', 600),
            ],
          );
        }
      },
    );
  }
}
