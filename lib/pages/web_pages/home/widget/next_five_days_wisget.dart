import 'package:flutter/material.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';
import 'package:provider/provider.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';

class NextFiveDaysWeb extends StatefulWidget {
  @override
  _NextFiveDaysWebState createState() => _NextFiveDaysWebState();
}

class _NextFiveDaysWebState extends State<NextFiveDaysWeb> {
  final List<Color> _colors = [
    Colors.blue[900],
    Colors.blue[800],
    Colors.blue[700],
    Colors.blue[600],
    Colors.blue[500]
  ];

  Day _tappedDay;
  Color _tappedColor;

  @override
  Widget build(BuildContext context) {
    final FiveDaysWeather nextFiveDays = Provider.of<NextFiveDaysWeather>(context).getFiveDaysWeather;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...nextFiveDays.days.asMap().map( (index, singleDay) => MapEntry(index, Expanded(
                child: GestureDetector(
                  onTap: () {setState(() {
                    _tappedDay = singleDay;
                    _tappedColor = _colors[index];
                  });},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    height: 280,
                    color: _colors[index],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(singleDay.day.substring(0,3).toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 18)),
                            SizedBox(height: 10),
                            Text(singleDay.weather.status, style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Image.asset(
                          WeatherIcon.selectIcon(singleDay.weather.status),
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
          ),
        ),
        SizedBox(height: 20),
        _tappedDay != null
            ? Text(_tappedDay.day.toUpperCase(), style: TextStyle( color: _tappedColor))
            : Text(nextFiveDays.days.first.day.toUpperCase(), style: TextStyle( color: _colors[0])),
        SizedBox(height: 10),
        Icon(Icons.keyboard_arrow_down, size: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                alignment: Alignment.center,
                child: ListTile(
                  title: Text('VENTO'),
                  subtitle: _tappedDay != null ? Text(_tappedDay.weather.wind) : Text(nextFiveDays.days.first.weather.wind),
                  leading: Image.asset('assets/img/wind.png', height: 40),
                ),
              ),
              Container(
                width: 200,
                child: ListTile(
                  title: Text('UMIDITÀ'),
                  subtitle: _tappedDay != null ? Text(_tappedDay.weather.wind) : Text(nextFiveDays.days.first.weather.wind),
                  leading: Image.asset('assets/img/drop.png', height: 40),
                ),
              ),
              Container(
                width: 200,
                child: ListTile(
                  title: Text('PRESSIONE'),
                  subtitle: _tappedDay != null ? Text(_tappedDay.weather.wind) : Text(nextFiveDays.days.first.weather.wind),
                  leading: Image.asset('assets/img/speedometer.png', height: 40),
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}
