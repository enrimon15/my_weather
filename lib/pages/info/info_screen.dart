import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  static const routeName = '/info';

  _launchURL(BuildContext context) async {
    const url = 'http://cetemps.aquila.infn.it';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showSnakeBar(tr("info_error") + '$url', context);
    }
  }

  _showSnakeBar(String text, BuildContext context) {
    final snackBar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: tr("info_title"),
          isTabBar: false,
          context: context
      ).getAppBar(),
      drawer: MainDrawer(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/img/icons/cielocoperto.png', height: 26),
                  const SizedBox(width: 20),
                  const Text('My Weather', style: TextStyle(fontSize: 16))
                ],
              ),
              const SizedBox(height: 15),
              Text('Developed by Enrico Monte', style: TextStyle(color: Theme.of(context).primaryColor, letterSpacing: 0.5, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Powered by ',
                      style: TextStyle(color: Colors.black)
                    ),
                    TextSpan(
                      text: 'CETEMPS',
                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchURL(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text('Copyright © 2020 Univaq. All rights reserved.')
            ],
          ),
        ),
      ),
    );
  }
}
