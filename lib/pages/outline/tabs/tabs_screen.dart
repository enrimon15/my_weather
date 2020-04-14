import 'package:flutter/material.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:my_weather/pages/details/weather_details_screen.dart';
import 'package:my_weather/pages/home/weather_home_screen.dart';
import 'package:my_weather/pages/map/weather_map_screen.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';
import 'package:my_weather/pages/outline/tabs/show_alert_widget.dart';
import 'package:my_weather/providers/search_cities.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:my_weather/utilities/location.dart';
import 'package:provider/provider.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TabScreen extends StatefulWidget {

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  bool _isLoading = false; //to check the completion of the fetching data
  bool _isInit = true; //to check fist time the screen is loaded
  bool _isErrorFetching = false; //to check if there is an error in fetching data
  bool _locationPermission = true;
  int _selectedIndex = 0; //to know which tab is pressed
  CityFavorite _currentCity = new CityFavorite(); //current city
  bool _isFavoriteCity = false; //to check if current city is favorite
  bool _isSearchReady = false;
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
        _locationPermission = true;
      });

      _loadSearch();

      //_getPrefs();

      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>; //take param from route
      if (routeArgs != null) { //if there are params (city, province) fetch data from server with this params
        print(routeArgs);
        _fetchData(routeArgs['name'], routeArgs['province'], context);
      } else {
        //get current location, from location get relative city and then pass it to the fetchWeatherData method
        LocationHelper.fetchLocation().then( (city) => _fetchData(city, 'NULL', context) )
        .catchError((error) => _handleInitError(error));
      }

    }
    _isInit = false; //is not any more first time
    super.didChangeDependencies();
  }

  //load all cities from a json
  _loadSearch() {
    final searchProvider = Provider.of<SearchCities>(context, listen: false);
    if (searchProvider.getAllCities.length <= 0) {
      searchProvider.fetchData().then( (_) {
        setState(() { _isSearchReady = true; });
      });
    }
  }

  //fare un provider
  _getPrefs() {
    SharedPreferences.getInstance().then( (prefs) {
      prefs.getString(InternationalizationConstants.PREFS_METRIC_KEY) ?? InternationalizationConstants.CELSIUS;
    });
  }

  //it fetches data from server and then check if city is favorite or not
  void _fetchData(String city, String province, BuildContext context) {
    //final searchProvider = Provider.of<SearchCities>(context, listen: false);
    //this wait for a list of operations passed into an array inside .wait
    Future
      .wait([
        Provider.of<TodayWeather>(context, listen: false).fetchData(city, province),
        Provider.of<NextFiveDaysWeather>(context, listen: false).fetchData(city, province),
        //if (searchProvider.getAllCities.length <= 0) searchProvider.fetchData()
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
    print(error.toString());
    switch (error.toString()) {
      case 'NO LOCATION PERMISSION' : {setState(() {_locationPermission = false;});}
      break;

      default: setState(() {_isErrorFetching = true;});
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0, //default page
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            tabItem: this._choices,
            onTabPressed: _onItemTapped,
            title: 'My Weather',
            isTabBar: true,
            context: context,
            isSearchReady: _isSearchReady
          ).getAppBar(),
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
    } else if (_isLoading) {
        return Center(child: CircularProgressIndicator());
    } else {
        return TabBarView(
          //physics: _selectedIndex == 2 ? NeverScrollableScrollPhysics() : null,
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