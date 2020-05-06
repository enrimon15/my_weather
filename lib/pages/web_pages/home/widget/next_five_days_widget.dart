import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/pages/web_pages/home/widget/expandable_details_widget.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:my_weather/services/icon_service.dart';
import 'package:my_weather/services/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';

class NextFiveDaysWeb extends StatefulWidget {
  @override
  _NextFiveDaysWebState createState() => _NextFiveDaysWebState();
}

class _NextFiveDaysWebState extends State<NextFiveDaysWeb> {
  final iconService = locator<WeatherIconService>();
  final List<Color> _colors = [
    Colors.blue[900],
    Colors.blue[800],
    Colors.blue[700],
    Colors.blue[600],
    Colors.blue[500]
  ];

  Day _tappedDay;
  Color _tappedColor;

  Widget _buildListNextDays(FiveDaysWeather nextFiveDays) {
    return Row(
      children: <Widget>[
        ...nextFiveDays.days.asMap().map( (index, singleDay) => MapEntry(index, Expanded(
          child: GestureDetector(
            onTap: () {setState(() {
              _tappedDay = singleDay;
              _tappedColor = _colors[index];
            });},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              height: 280,
              color: _colors[index],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(singleDay.day.substring(0,3).toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 10),
                      Text(singleDay.weather.status, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Image.asset(
                    iconService.selectIcon(singleDay.weather.status),
                    height: 48,
                  ),
                  Text(
                    singleDay.weather.temperature,
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ],
              ),
            ),
          ).showCursorOnHover.moveUpOnHover,
        ))).values.toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final FiveDaysWeather nextFiveDays = Provider.of<NextFiveDaysWeather>(context).getFiveDaysWeather;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: _buildListNextDays(nextFiveDays),
        ),
        const SizedBox(height: 20),
        _tappedDay != null
            ? Text(_tappedDay.day.toUpperCase(), style: TextStyle( color: _tappedColor))
            : Text(nextFiveDays.days.first.day.toUpperCase(), style: TextStyle( color: _colors[0])),
        const SizedBox(height: 10),
        const Icon(Icons.keyboard_arrow_down, size: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: ExpandableDetails(_tappedDay, nextFiveDays.days.first.weather),
        ),
      ]
    );
  }
}
