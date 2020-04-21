import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:my_weather/pages/details/weather_details_screen.dart';
import 'package:my_weather/pages/home/weather_home_screen.dart';
import 'package:my_weather/pages/map/weather_map_screen.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer_widget.dart';
import 'package:my_weather/pages/outline/show_alert_widget.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';


class TabScreen extends StatefulWidget {
  final Map<String, bool> _prerequisites;

  TabScreen(this._prerequisites);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0; //to know which tab is pressed
  CityFavorite _currentCity = new CityFavorite(); //current city
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); //key of context, for snakebar

  //List of tabs
  final List<TabItem> _choices = [
    TabItem(title: tr("tab_today"), screen: Home()),
    TabItem(title: tr("tab_details"), screen: Details()),
    TabItem(title: tr("tab_map"), screen: Maps()),
  ];

  // it listens tap on tab and change _selectedIndex, FAB will show or hide
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // it handles the tap on FAB of favorite city, remove/add city from favorites
  _handleFavorite(bool isFavoriteCity) async {
    bool result;
    if (!isFavoriteCity) {
      result = await DBHelper.insertCity(_currentCity);
      result ? setState(() {isFavoriteCity = true;}) : _showSnakebar(tr("snackbar_favorite_add_error"));
    } else {
      result = await DBHelper.delete(_currentCity);
      result ? setState(() {isFavoriteCity = false;}) : _showSnakebar(tr("snackbar_favorite_remove_error"));
    }
  }

  //it shows snakebar with given text
  _showSnakebar(String message) {
    _scaffoldKey.currentState.showSnackBar( SnackBar(content: Text(message)) );
  }


  @override
  Widget build(BuildContext context) {
    Map<String, bool> prerequisites = widget._prerequisites;

    final appBar = CustomAppBar(
        tabItem: this._choices,
        onTabPressed: _onItemTapped,
        title: 'My Weather',
        isTabBar: true,
        context: context,
    ).getAppBar();

    return DefaultTabController(
        initialIndex: 0, //default page
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: appBar,
          drawer: MainDrawer(),
          body: _buildBody(context, prerequisites),
          floatingActionButton: kIsWeb ? null : _buildFAB(prerequisites['isFavoriteCity']),
        )
    );
  }

  Widget _buildBody(BuildContext context, Map<String, bool> prerequisites) {
    if (prerequisites['isErrorFetching']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("generic_error"),
        buttonContent: tr("try_again"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
      );
    }
    else if (!prerequisites['locationPermissionSettings']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_settings_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => AppSettings.openLocationSettings(),
      );
    }
    else if (!prerequisites['locationPermissionPrefs']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_prefs_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName),
      );
    }
    else if (!prerequisites['locationPermissionApp']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_app_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => AppSettings.openAppSettings(),
      );
    }
    else if (!prerequisites['isConnectivity']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("connection_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => AppSettings.openWIFISettings(),
      );
    }
    else if (prerequisites['isLoading']) {
      return Center(child: CircularProgressIndicator());
    } else {
        return TabBarView(
          children: _choices.map((TabItem choice){
            return choice.screen;
          }).toList(),
        );
    }
  }

  Widget _buildFAB(bool isFavoriteCity) {
    if (_selectedIndex != 1) return null; //show fab only in details tab
    else {
      return FloatingActionButton(
        child: isFavoriteCity ? Icon(Icons.star, color: Colors.white) : Icon(Icons.star_border, color: Colors.white),
        onPressed: () => _handleFavorite(isFavoriteCity),
      );
    }
  }

}