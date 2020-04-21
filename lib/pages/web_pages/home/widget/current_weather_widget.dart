import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class CurrentWeather extends StatelessWidget {
  final city;
  final currentWeather;
  final date;

  CurrentWeather(this.city, this.currentWeather, this.date);

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        AutoSizeText.rich(
          TextSpan(
              children: <TextSpan> [
                TextSpan(text: city),
                TextSpan(text: ',   '),
                TextSpan(text: '${currentWeather.temperature.split(' ')[0]}°', style: TextStyle( fontSize: 40))
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Theme.of(context).primaryColor, Colors.blue]
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildHeader(),
          Image.asset(
            WeatherIcon.selectIcon(currentWeather.status),
            height: 80,
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
      ),
    );
  }
}
