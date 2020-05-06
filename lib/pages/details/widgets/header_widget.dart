import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:my_weather/models/generic_weather.dart';
import 'package:my_weather/services/icon_service.dart';
import 'package:my_weather/services/service_locator.dart';

class Header extends StatelessWidget {
  final String cityName;
  final GenericWeather currentWeather;
  final iconService = locator<WeatherIconService>();

  Header({
    @required this.cityName,
    @required this.currentWeather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildColumnHeader(cityName, context),
          Image.asset(
            iconService.selectIcon(currentWeather.status),
            height: 80,
          ),
        ],
      ),
    );
  }

  _buildColumnHeader(String cityName, BuildContext context) { //to make it responsive
    return cityName.split(',')[0].length > 10
        ? Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${currentWeather.temperature.split(' ')[0]}°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 70
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                AutoSizeText(
                  cityName,
                  maxLines: 1,
                  minFontSize: 8,
                  overflowReplacement: Text(''),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20
                  ),
                ),
              ],
            ),
        )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${currentWeather.temperature.split(' ')[0]}°',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 70
                ),
              ),
              const SizedBox(height: 5),
              Text(
                cityName,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20
                ),
              ),
            ],
          );
    }

}

/*

 */
