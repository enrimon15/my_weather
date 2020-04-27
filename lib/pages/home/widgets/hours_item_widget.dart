import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class HourItem extends StatelessWidget {
  final Hour hour;

  HourItem(this.hour);

  @override
  Widget build(BuildContext context) {
    final DateTime now = new DateTime.now();
    String nowString = now.hour.toString();
    nowString = nowString.length == 1 ? '0$nowString:00' : '$nowString:00';

    final _isNow = hour.hour == nowString;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _isNow ? _buildNowHour() : _buildGenericHour(context),
    );
  }

  //builder method
  Widget _buildNowHour() {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        //20.9
        final constr = constraints.maxHeight * 0.15;
        double paddingNowItem = constr > 20 ? constr : 8;
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: const BorderRadius.vertical(
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
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: paddingNowItem),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  tr("home_now"),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Image.asset(
                WeatherIcon.selectIcon(hour.weather.status),
                //alignment: Alignment.bottomLeft,
                height: 34,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGenericHour(BuildContext context) {
    return Column(
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
          style: const TextStyle(
            fontSize: 15,
          ),
        )
      ],
    );
  }

}
