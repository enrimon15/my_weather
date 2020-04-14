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
  bool isSearchReady = true;

  CustomAppBar({
    this.tabItem,
    this.onTabPressed,
    @required this.isTabBar,
    @required this.title,
    @required this.context,
    this.isSearchReady,
  });

   AppBar getAppBar() {
    if (this.isTabBar) {
       return AppBar(
        title: Text(this.title),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => isSearchReady ? showSearch(context: context, delegate: DataSearch()) : null,
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
    }
    else {
       return AppBar(
        title: Text(this.title),
        elevation: 10,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => showSearch(context: context, delegate: DataSearch()),
          ),
        ],
      );
    }
  }

}