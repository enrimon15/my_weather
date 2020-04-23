import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/pages/search/data_search.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';

class CustomNavbar {
  final String title;
  final BuildContext context;
  static double height;

  CustomNavbar({
    @required this.title,
    @required this.context,
  });

  final List<String> settingsList = [
    'IT | C°',
    'EN | °F'
  ];

  AppBar getNavbar() {
    final simpleAppBar = AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/img/icons/cielocoperto.png', height: 32),
      ),
      title: Text(this.title, textAlign: TextAlign.left,),
      elevation: 10,
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          child: Row(
            children: <Widget>[
              Text('Home', style: TextStyle( color: Colors.white) ),
              SizedBox(width: 8),
              Icon(
                Icons.home,
                color: Colors.white,
              ),
            ],
          ),
        ).showCursorOnHover,
        SizedBox(width: 15,),
        GestureDetector(
          onTap: () => showSearch(context: context, delegate: DataSearch()),
          child: Row(
            children: <Widget>[
              Text('Cerca', style: TextStyle( color: Colors.white) ),
              SizedBox(width: 8),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              /*IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                onPressed: () => showSearch(context: context, delegate: DataSearch()),
              ),*/
            ],
          ),
        ).showCursorOnHover,
        SizedBox(width: 55),
        Row(
          children: <Widget>[
            Text('IT | C°', style: TextStyle(color: Colors.white)),
            PopupMenuButton<String>(
              tooltip: 'Cambia la lingua',
              icon: Icon(Icons.arrow_drop_down).showCursorOnHover,
              initialValue: 'IT',
              onSelected: (String result) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'IT',
                  child: Text('IT | C°'),
                ),
                const PopupMenuItem<String>(
                  value: 'EN',
                  child: Text('EN | °F'),
                ),
              ],
            ),
          ],
        )

      ],
    );

    height = simpleAppBar.preferredSize.height;
    return simpleAppBar;
  }

}