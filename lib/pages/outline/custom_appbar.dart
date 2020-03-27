import 'package:flutter/material.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/pages/search/search_screen.dart';

class CustomAppBar {
  final List<TabItem> tabItem;
  final bool isTabBar;
  final String title;
  final BuildContext context;

  CustomAppBar({
    this.tabItem,
    @required this.isTabBar,
    @required this.title,
    @required this.context
  });

   AppBar getAppBar() {
    if (this.isTabBar) {
       return AppBar(
        title: Text(this.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 15),
          indicatorColor: Colors.white,
          tabs: this.tabItem.map((TabItem choice) {
            return Tab(
              text: choice.title,
            );
          }).toList(),
        ),
      );
    }
    else {
       return AppBar(
        title: Text('My Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
          ),
        ],
      );
    }
  }

}