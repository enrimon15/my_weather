import 'package:flutter/material.dart';
import 'package:my_weather/models/tab_item.dart';
import 'package:my_weather/pages/details/weather_details_screen.dart';
import 'package:my_weather/pages/home/weather_home_screen.dart';
import 'package:my_weather/pages/map/weather_map_screen.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';


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

  //this runs only one time before that the widget is rendered
  @override
  void initState() {
    Provider.of<TodayWeather>(context, listen: false).fetchData('Torrebruna', 'CH'); //with "listen: false" it isn't rebuilt
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final checkFetchData = Provider.of<TodayWeather>(context);

    return DefaultTabController(
        initialIndex: 0, //default page
        length: 3,
        child: Scaffold(
          appBar: CustomAppBar(
            tabItem: this._choices,
            shadow: false, //si potrebbe fare una cosa con il provider
            title: 'My Weather',
            isTabBar: true,
            context: context
          ).getAppBar(),
          drawer: MainDrawer(),
          body: checkFetchData.isFetching
            ? checkFetchData.isFetchError
              ? AlertDialog(title: Text("Errore"), content: Text("OPSS.. Qualcosa è andato storto"))
              : Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: _choices.map((TabItem choice){
                  return choice.screen;
                }).toList(),
            ),
        )
    );
  }
}