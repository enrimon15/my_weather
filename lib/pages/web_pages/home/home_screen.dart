import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/map/widgets/leaflet_map_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/current_weather_widget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class HomeWeb extends StatelessWidget {
  final DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    final intlLocale = EasyLocalization.of(context).locale.toString();
    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final todayWeather = weatherProvider.getTodayWeather;
    final currentWeather = weatherProvider.getCurrentWeather;
    final coords = weatherProvider.getCityCoords;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      shrinkWrap: true,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: CurrentWeather(
                todayWeather.cityName,
                currentWeather,
                '${DateFormat.EEEE(intlLocale).format(DateTime.now())} ${now.day}'
              ),
            ),
            SizedBox(width: 40),
            Expanded(
              child: Container(
                height: 350,
                child: LeafletMapWidget(coords),
              ),
            )
          ],
        )
      ],
    );
  }
}
