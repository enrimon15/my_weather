import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/pages/search/data_search.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavbar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final AppBar appBar;

  CustomNavbar({
    @required this.title,
    @required this.appBar,
  });

  @override
  _CustomNavbarState createState() => _CustomNavbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class _CustomNavbarState extends State<CustomNavbar> {
  SharedPreferences sPref;

  final Map<String, String> _unitsTextBinding = {
    InternationalizationConstants.METRIC : 'C°',
    InternationalizationConstants.IMPERIAL : '°F'
  };

  String _getMenuTextLocalization(String lang, String unit) {
    return '$lang | ${_unitsTextBinding[unit]}';
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then( (prefs) {
      sPref = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = EasyLocalization.of(context).locale;
    String _lang = currentLocale.languageCode.toUpperCase();

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/img/icons/cielocoperto.png', height: 32),
      ),
      title: Text(widget.title, textAlign: TextAlign.left,),
      elevation: 10,
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('/'),
          child: Row(
            children: <Widget>[
              Text(tr("web_navbar_home"), style: TextStyle( color: Colors.white) ),
              const SizedBox(width: 8),
              const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ],
          ),
        ).showCursorOnHover,
        const SizedBox(width: 15,),
        GestureDetector(
          onTap: () => showSearch(context: context, delegate: DataSearch()),
          child: Row(
            children: <Widget>[
              Text(tr("web_navbar_search"), style: TextStyle( color: Colors.white) ),
              const SizedBox(width: 8),
              const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ],
          ),
        ).showCursorOnHover,
        const SizedBox(width: 55),
        Row(
          children: <Widget>[
            FutureBuilder(
              future: InternationalizationConstants.getUnits(),
              builder: (ctx, snapshot) => snapshot.hasData
                  ? Text(_getMenuTextLocalization(_lang, snapshot.data), style: TextStyle(color: Colors.white))
                  : Text ('')
            ),
            Tooltip(
              message: tr("web_navbar_tootltip_localization"),
              child: IconButton(
                icon: Icon(Icons.language),
                onPressed: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
              ).showCursorOnHover,
            )
          ],
        )
      ],
    );
  }
}