import 'package:flutter/material.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/pages/search/data_search.dart';

class CustomAppBar {
  final List<TabItem> tabItem;
  final bool isTabBar;
  final String title;
  final BuildContext context;
  final Function onTabPressed;
  static double height;

  CustomAppBar({
    this.tabItem,
    this.onTabPressed,
    @required this.isTabBar,
    @required this.title,
    @required this.context,
  });



   AppBar getAppBar() {

    if (this.isTabBar) {
      final tabAppBar = AppBar(
        title: Text(this.title),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => showSearch(context: context, delegate: DataSearch()),
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 15),
          indicatorColor: Colors.white,
          indicator: UnderlineTabIndicator( //for width of tab indicator
            insets: EdgeInsets.symmetric(horizontal:30.0),
          ),
          tabs: this.tabItem.map((TabItem choice) {
            return Tab(
              text: choice.title,
            );
          }).toList(),
          onTap: (index) => onTabPressed(index),
        ),
      );

       height = tabAppBar.preferredSize.height;
       return tabAppBar;
    }
    else {
      final simpleAppBar = AppBar(
        title: Text(this.title),
        elevation: 10,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => showSearch(context: context, delegate: DataSearch()),
          ),
        ],
      );

       height = simpleAppBar.preferredSize.height;
       return simpleAppBar;
    }
  }

}