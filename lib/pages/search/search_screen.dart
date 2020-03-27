import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Weather'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Search'),
      ),
    );
  }
}
