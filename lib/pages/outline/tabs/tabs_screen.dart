import 'package:flutter/material.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:my_weather/pages/details/weather_details_screen.dart';
import 'package:my_weather/pages/home/weather_home_screen.dart';
import 'package:my_weather/pages/map/weather_map_screen.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  //List of tabs
  final List<TabItem> _choices = [
    TabItem(title: 'Oggi', screen: Home()),
    TabItem(title: 'Dettagli', screen: Details()),
    TabItem(title: 'Mappa', screen: Map()),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0, //default page
        length: 3,
        child: Scaffold(
          appBar: CustomAppBar(
            tabItem: this._choices,
            title: 'My Weather',
            isTabBar: true,
            context: context
          ).getAppBar(),
          drawer: MainDrawer(),
          body: TabBarView(
            children: _choices.map((TabItem choice){
              return choice.screen;
            }).toList(),
          ),
        )
    );
  }
}