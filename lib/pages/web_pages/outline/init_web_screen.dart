import 'package:flutter/material.dart';
import 'package:my_weather/pages/_layout/check_prerequisites.dart';
import 'package:my_weather/pages/web_pages/home/home_screen.dart';
import 'package:my_weather/pages/web_pages/outline/custom_navbar_web.dart';

class InitScreenWeb extends StatefulWidget {
  final Map<String, bool> _prerequisites;

  InitScreenWeb(this._prerequisites);

  @override
  _InitScreenWebState createState() => _InitScreenWebState();
}

class _InitScreenWebState extends State<InitScreenWeb> {
  @override
  Widget build(BuildContext context) {

    Map<String, bool> prerequisites = widget._prerequisites;

    final navbar = CustomNavbar(
      title: 'My Weather',
      appBar: AppBar(),
    );

    return Scaffold(
      appBar: navbar,
      body: CheckPrerequisites(
        isTabBar: false,
        prerequisites: prerequisites,
        screen: HomeWeb(),
      ),
    );
  }

}
