import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Weather'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Favorites'),
      ),
    );
  }
}
