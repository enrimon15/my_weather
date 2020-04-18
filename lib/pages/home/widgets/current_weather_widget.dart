import 'package:auto_size_text/auto_size_text.dart';
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
    final heightContainer = (mediaQuery.size.height - CustomAppBar.height - mediaQuery.padding.top) * 0.72;

    final _principalColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildHeader(
            weatherProvider.getTodayWeather.cityName + ',',
            currentWeather.temperature.split(' ')[0] + '°',
            '${DateFormat.EEEE(intlLocale).format(DateTime.now())} ${now.day}',
            mediaQuery
        ),
        //SizedBox(height: 30,),
        Image.asset(
          WeatherIcon.selectIcon(currentWeather.status),
          height: 105,
        ),
        //SizedBox(height: 30,),
        AutoSizeText(
          currentWeather.status,
          style: TextStyle(
            letterSpacing: 8,
            fontSize: 20,
            color: Colors.white,
          ),
          maxLines: 1,
          minFontSize: 8,
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.only(bottom: 75, right: 5, left: 5),
      width: double.infinity,
      height: heightContainer,
      color: Theme.of(context).primaryColor,
      child: heightContainer > 301
          ? _principalColumn
          : FittedBox(child: _principalColumn)

    );
  }

  Widget _buildHeader(String city, String temp, String date, MediaQueryData mediaQueryData) {
    return Column(
      children: <Widget>[
        AutoSizeText.rich(
          TextSpan(
              children: <TextSpan> [
                TextSpan(text: city),
                TextSpan(text: '   '),
                TextSpan(text: temp, style: TextStyle( fontSize: 40))
              ]
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
          maxLines: 1,
          minFontSize: 0,
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
