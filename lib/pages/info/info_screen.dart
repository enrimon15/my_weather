import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';

class InfoScreen extends StatelessWidget {
  static const routeName = '/info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Weather'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Info'),
      ),
    );
  }
}
