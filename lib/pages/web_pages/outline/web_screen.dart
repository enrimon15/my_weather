import 'package:flutter/material.dart';
import 'package:my_weather/pages/_init_data/check_prerequisites.dart';
import 'package:my_weather/pages/web_pages/home/home_screen.dart';
import 'package:my_weather/pages/web_pages/outline/custom_navbar_web.dart';

class ScreenWeb extends StatefulWidget {
  final Map<String, bool> _prerequisites;

  ScreenWeb(this._prerequisites);

  @override
  _ScreenWebState createState() => _ScreenWebState();
}

class _ScreenWebState extends State<ScreenWeb> {
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
