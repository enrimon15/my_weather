import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class TempCard extends StatelessWidget {
  final Map<String,int> temperatureAverage;

  TempCard(this.temperatureAverage);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'assets/img/maxtemp.png',
              height: 48,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: AutoSizeText.rich(
                TextSpan(
                  children: <TextSpan> [
                    TextSpan(text: 'MAX'),
                    TextSpan(text: '  '),
                    TextSpan(
                        text: '${temperatureAverage['max']}°',
                        style: GoogleFonts.lato( textStyle: TextStyle(color: Colors.grey) ),
                    ),
                  ]
                ),
                maxLines: 1,
                minFontSize: 0,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AutoSizeText.rich(
                TextSpan(
                  children: <TextSpan> [
                    TextSpan(
                      text: '${temperatureAverage['min']}°',
                      style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.grey)),
                    ),
                    TextSpan(text: '  '),
                    TextSpan(text: 'MIN'),
                  ],
                ),
                maxLines: 1,
                minFontSize: 0,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 6),
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
