import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class CurrentWeatherWeb extends StatelessWidget {
  final city;
  final currentWeather;
  final date;
  final temperatureAverage;

  CurrentWeatherWeb(this.city, this.currentWeather, this.date, this.temperatureAverage);

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

  Widget _buildMinMaxTemp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Image.asset(
          'assets/img/maxtemp.png',
          height: 48,
        ),
        SizedBox(width: 6),
        Expanded(
          child: AutoSizeText.rich(
            TextSpan(
                children: <TextSpan> [
                  TextSpan(text: 'MAX', style: TextStyle(color: Colors.white)),
                  TextSpan(text: '  '),
                  TextSpan(
                    text: '${temperatureAverage['max']}°',
                    style: GoogleFonts.lato( textStyle: TextStyle(color: Colors.white70) ),
                  ),
                ]
            ),
            maxLines: 1,
            minFontSize: 0,
            textAlign: TextAlign.left,
          ),
        ),
        //Spacer(),
        SizedBox(width: 10),
        Expanded(
          child: AutoSizeText.rich(
            TextSpan(
              children: <TextSpan> [
                TextSpan(
                  text: '${temperatureAverage['min']}°',
                  style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.white70)),
                ),
                TextSpan(text: '  '),
                TextSpan(text: 'MIN', style: TextStyle(color: Colors.white)),
              ],
            ),
            maxLines: 1,
            minFontSize: 0,
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 6),
        Image.asset(
          'assets/img/mintemp.png',
          height: 48,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
          _buildMinMaxTemp(),
        ],
      ),
    );
  }
}
