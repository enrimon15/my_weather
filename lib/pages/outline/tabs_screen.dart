import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/exceptions/configuration_exception.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:my_weather/pages/details/weather_details_screen.dart';
import 'package:my_weather/pages/home/weather_home_screen.dart';
import 'package:my_weather/pages/map/weather_map_screen.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer_widget.dart';
import 'package:my_weather/pages/outline/show_alert_widget.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:my_weather/utilities/connectivity.dart';
import 'package:my_weather/utilities/location.dart';
import 'package:provider/provider.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:easy_localization/easy_localization.dart';


class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  bool _isLoading = false; //to check the completion of the fetching data
  bool _isInit = true; //to check fist time the screen is loaded
  bool _isErrorFetching = false; //to check if there is an error in fetching data
  bool _locationPermissionPrefs = true; //to check if there is location permission from shared preferences
  bool _locationPermissionSettings = true; //to check if there is location permission from system settings
  bool _locationPermissionApp = true; //to check if there is location permission from app settings
  bool _isConnectivity = true; //to check if connection is up
  int _selectedIndex = 0; //to know which tab is pressed
  CityFavorite _currentCity = new CityFavorite(); //current city
  bool _isFavoriteCity = false; //to check if current city is favorite
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); //key of context, for snakebar

  //List of tabs
  final List<TabItem> _choices = [
    TabItem(title: tr("tab_today"), screen: Home()),
    TabItem(title: tr("tab_details"), screen: Details()),
    TabItem(title: tr("tab_map"), screen: Maps()),
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) { //if is the first time that the screen is loaded

      setState(() { //reset all variables
        _isLoading = true;
        _isErrorFetching = false;
        _isFavoriteCity = false;
        _locationPermissionPrefs = true;
        _locationPermissionSettings = true;
        _locationPermissionApp = true;
        _isConnectivity = true;
      });

      ConnectionUtility.checkConnection().then( (conn) { //check connectivity
        if(conn) { //if there is connection
          final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>; //take param from route
          if (routeArgs != null) { //if there are params (city, province) fetch data from server with this params
            print('routeArgs: ' + routeArgs.toString());
            _fetchData(routeArgs['name'], routeArgs['province'], context);
          } else {
            //get current location, from location get relative city and then pass it to the fetchWeatherData method
            LocationHelper.fetchLocation().then( (city) => _fetchData(city, 'NULL', context) )
                .catchError((error) => _handleInitError(error));
          }
        } else { //if there is no connection
          throw ConfigurationException('NO INTERNET CONNECTION');
        }
      }).catchError((error) => _handleInitError(error));



    }
    _isInit = false; //is not any more first time
    super.didChangeDependencies();
  }

  //it fetches data from server and then check if city is favorite or not
  void _fetchData(String city, String province, BuildContext context) {
    String lang = EasyLocalization.of(context).locale.languageCode.toUpperCase(); //language to send to server
    //this wait for a list of operations passed into an array inside .wait
    Future
      .wait([
        Provider.of<TodayWeather>(context, listen: false).fetchData(city, province, lang),
        Provider.of<NextFiveDaysWeather>(context, listen: false).fetchData(city, province, lang),
      ])
      .then((_) {
        setState(() {
          _currentCity = Provider.of<TodayWeather>(context, listen: false).getCurrentCity; //get current city
          DBHelper.checkIsFavorite(_currentCity).then( (checkCity) { //check if city is favorite
            if (checkCity != null) { //if != null, the city is favorite
              _isFavoriteCity = true;
              _currentCity = checkCity;
            }
          });
          _isLoading = false;
        });
      })
    .catchError((error) => _handleInitError(error));
  }

  // it listens tap on tab and change _selectedIndex, FAB will show or hide
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // it handles the tap on FAB of favorite city, remove/add city from favorites
  _handleFavorite() async {
    bool result;
    if (!_isFavoriteCity) {
      result = await DBHelper.insertCity(_currentCity);
      result ? setState(() {_isFavoriteCity = true;}) : _showSnakebar(tr("snackbar_favorite_add_error"));
    } else {
      result = await DBHelper.delete(_currentCity);
      result ? setState(() {_isFavoriteCity = false;}) : _showSnakebar(tr("snackbar_favorite_remove_error"));
    }
  }

  //it shows snakebar with given text
  _showSnakebar(String message) {
    _scaffoldKey.currentState.showSnackBar( SnackBar(content: Text(message)) );
  }

  //it handle init error of app (fetching data, location, check ecc)
  _handleInitError(error) {
    print('init error: ' + error.toString());
    switch (error.toString()) {
      case 'LOCATION PERMISSION SETTINGS NOT ENABLED' : {setState(() {_locationPermissionApp = false;});}
      break;

      case 'LOCATION PERMISSION PREFS NOT ENABLED' : {setState(() {_locationPermissionPrefs = false;});}
      break;

      case 'LOCATION SERVICE NOT ENABLED' : {setState(() {_locationPermissionSettings = false;});}
      break;

      case 'NO INTERNET CONNECTION' : {setState(() {_isConnectivity = false;});}
      break;

      default: setState(() {_isErrorFetching = true;});
    }
  }


  @override
  Widget build(BuildContext context) {

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
          body: _buildBody(context),
          floatingActionButton: _buildFAB(),
        )
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isErrorFetching) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("generic_error"),
        buttonContent: tr("try_again"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
      );
    }
    else if (!_locationPermissionSettings) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_settings_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => AppSettings.openLocationSettings(),
      );
    }
    else if (!_locationPermissionPrefs) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_prefs_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName),
      );
    }
    else if (!_locationPermissionApp) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_app_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => AppSettings.openAppSettings(),
      );
    }
    else if (!_isConnectivity) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("connection_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => AppSettings.openWIFISettings(),
      );
    }
    else if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
        return TabBarView(
          children: _choices.map((TabItem choice){
            return choice.screen;
          }).toList(),
        );
    }
  }

  Widget _buildFAB() {
    if (_selectedIndex != 1) return null; //show fab only in details tab
    else {
      return FloatingActionButton(
        child: _isFavoriteCity ? Icon(Icons.star, color: Colors.white) : Icon(Icons.star_border, color: Colors.white),
        onPressed: () => _handleFavorite(),
      );
    }
  }

}