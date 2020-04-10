import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartBar extends StatelessWidget {
  final String label; //day
  final String temp; //temperature
  final double height; //height of the bar, it's a percentage calculate on max temp of five days

  ChartBar(this.label, this.temp, this.height);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 15,
          child: FittedBox(
              child: Text(
                '$temp°',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
              )
          ),
        ),
        SizedBox(height: 20,),
        Tooltip(
          message: '$temp°',
          child: Container(
            height: 100,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border:  Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: height,
                  child: Container(
                    decoration: BoxDecoration(
                      color:  Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 15,
          child: FittedBox(
              child: Text(label.substring(0,3).toUpperCase())
          ),
        ),
      ],
    );
  }
}
