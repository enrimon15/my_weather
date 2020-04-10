import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class TempCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final temperatureAverage = Provider.of<TodayWeather>(context).getMinMaxTemp();


    return Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/img/maxtemp.png',
              height: 48,
            ),
            SizedBox(width: 6),
            Text('MAX'),
            SizedBox(width: 10),
            Text(
              '${temperatureAverage['max']}°',
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.grey),
              ),
            ),
            Spacer(),
            Text(
              '${temperatureAverage['min']}°',
              style: GoogleFonts.lato(
                textStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(width: 10),
            Text('MIN'),
            SizedBox(width: 6),
            Image.asset(
              'assets/img/mintemp.png',
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
