import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/img/icons/cielocoperto.png', height: 26),
                SizedBox(width: 20),
                Text('My Weather', style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
            SizedBox(height: 15),
            Text('Developed by Enrico Monte', style: TextStyle(color: Theme.of(context).accentColor, letterSpacing: 0.5, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Powered by ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'CETEMPS',
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () { launch('http://cetemps.aquila.infn.it'); },
                  ),
                ],
              ),
            ).showCursorOnHover,
            SizedBox(height: 10),
            Text('Copyright © 2020 Univaq. All rights reserved.')
          ],
        ),
      ),
    );
  }
}
