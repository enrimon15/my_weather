import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/show_alert_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';

class Footer extends StatelessWidget {

  _launchURL(BuildContext context) async {
    const url = 'http://cetemps.aquila.infn.it';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ShowAlert(
        title: 'Oops..',
        content: tr("info_error") + '$url',
        buttonContent: 'OK',
        onTap: () => Navigator.of(context).pop(),
      );
     //_showSnakeBar(tr("info_error") + '$url', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
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
                const SizedBox(width: 20),
                const Text('My Weather', style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
            const SizedBox(height: 15),
            Text('Developed by Enrico Monte', style: TextStyle(color: Theme.of(context).accentColor, letterSpacing: 0.5, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Powered by ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'CETEMPS',
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchURL(context),
                  ),
                ],
              ),
            ).showCursorOnHover,
            const SizedBox(height: 10),
            const Text('Copyright © 2020 Univaq. All rights reserved.')
          ],
        ),
      ),
    );
  }
}
