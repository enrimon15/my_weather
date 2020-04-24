import 'dart:html';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/exceptions/configuration_exception.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/pages/outline/tabs_screen.dart';
import 'package:my_weather/pages/web_pages/outline/init_screen.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:my_weather/utilities/connectivity.dart';
import 'package:my_weather/utilities/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class InitData extends StatefulWidget {
  final String pageType;

  InitData(this.pageType);

  @override
  _InitDataState createState() => _InitDataState();
}

class _InitDataState extends State<InitData> {

  Map<String, bool> _prerequisites= {
    'isLoading' : false, //to check the completion of the fetching data
    'isInit' : true, //to check fist time the screen is loaded
    'isErrorFetching' : false, //to check if there is an error in fetching data
    'locationPermissionPrefs' : true, //to check shared prefs location permission
    'locationPermissionSettings' : true, //to check system settings location permission
    'locationPermissionApp' : true, //to check app location permission
    'isConnectivity' : true, //to check connection status
    'isFavoriteCity' : false, //to check if city is favorite
  };
  CityFavorite _currentCity = new CityFavorite(); //current city

  @override
  void didChangeDependencies() {
    if (_prerequisites['isInit']) { //if is the first time that the screen is loaded

      setState(() { //reset all variables
        _prerequisites['isLoading'] = true;
        _prerequisites['isErrorFetching'] = false;
        _prerequisites['isFavoriteCity'] = false;
        _prerequisites['locationPermissionPrefs'] = true;
        _prerequisites['locationPermissionSettings'] = true;
        _prerequisites['locationPermissionApp'] = true;
        _prerequisites['isConnectivity'] = true;
      });

      if(kIsWeb) {
        _initAppData(context);
      } else {
        ConnectionUtility.checkConnection().then( (conn) { //check connectivity
          if(conn) { //if there is connection
            _initAppData(context);
          } else { //if there is no connection
            throw ConfigurationException('NO INTERNET CONNECTION');
          }
        }).catchError((error) => _handleInitError(error));
      }

    }
    _prerequisites['isInit'] = false; //is not any more first time
    super.didChangeDependencies();
  }

  _initAppData(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>; //take param from route
    if (routeArgs != null) { //if there are params (city, province) fetch data from server with this params
      print('routeArgs: ' + routeArgs.toString());
      _fetchData(routeArgs['name'], routeArgs['province'], context);
    } else {
      //get current location, from location get relative city and then pass it to the fetchWeatherData method
      LocationHelper.fetchLocation().then( (city) => _fetchData(city, 'NULL', context) )
          .catchError((error) => _handleInitError(error));
    }
  }

  //it handle init error of app (fetching data, location, check ecc)
  _handleInitError(error) {
    print('error: ' + error.toString());
    switch (error.toString()) {
      case 'LOCATION PERMISSION SETTINGS NOT ENABLED' : {setState(() {_prerequisites['locationPermissionApp'] = false;});}
      break;

      case 'LOCATION PERMISSION PREFS NOT ENABLED' : {setState(() {_prerequisites['locationPermissionPrefs'] = false;});}
      break;

      case 'LOCATION SERVICE NOT ENABLED' : {setState(() {_prerequisites['locationPermissionSettings'] = false;});}
      break;

      case 'NO INTERNET CONNECTION' : {setState(() {_prerequisites['isConnectivity'] = false;});}
      break;

      default: setState(() {_prerequisites['isErrorFetching'] = true;});
    }
  }


  //it fetches data from server and then check if city is favorite or not
  void _fetchData(String city, String province, BuildContext context) {
    String lang = EasyLocalization.of(context).locale.languageCode.toUpperCase(); //language to send to server
    //this wait for a list of operations passed into an array inside .wait
    Future.wait([
      Provider.of<TodayWeather>(context, listen: false).fetchData(city, province, lang),
      Provider.of<NextFiveDaysWeather>(context, listen: false).fetchData(city, province, lang),
    ])
    .then((_) {
      setState(() {
        if(!kIsWeb) {
          _currentCity = Provider.of<TodayWeather>(context, listen: false).getCurrentCity; //get current city
          DBHelper.checkIsFavorite(_currentCity).then( (checkCity) { //check if city is favorite
            if (checkCity != null) { //if != null, the city is favorite
              _prerequisites['isFavoriteCity'] = true;
              _currentCity = checkCity;
            }
          });
        }
        _prerequisites['isLoading'] = false;
      });
    })
    .catchError((error) => _handleInitError(error));
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.pageType) {
      case 'mobile' :
        return TabScreen(_prerequisites);
        break;

      case 'web' :
        return InitScreenWeb(_prerequisites);
        break;

       default: return TabScreen(_prerequisites);
    }
  }

}
