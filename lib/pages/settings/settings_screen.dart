import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer_widget.dart';
import 'package:my_weather/pages/web_pages/outline/navbar/custom_navbar_web.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _languages = InternationalizationConstants.languages;
  List<String> _listUnits = InternationalizationConstants.LIST_UNITS_DISPLAY;
  String _unitsKey = InternationalizationConstants.PREFS_UNITS_KEY;
  String _locationKey = InternationalizationConstants.PREFS_LOCATION_KEY;

  bool _isPosition;
  String _units;
  SharedPreferences prefs;

  bool _isPrefsLoaded = false;


  @override
  void initState() {
    super.initState();
    _getSharedPrefs().then( (_) { setState(() { _isPrefsLoaded = true; }); });
  }

  Future<void> _getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    _isPosition = prefs.getBool(_locationKey) ?? true;
    _units = prefs.getString(_unitsKey) ?? InternationalizationConstants.METRIC;
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue, Function updateValue, Icon icon) {
    return SwitchListTile(
      title: Text(title),
      subtitle: AutoSizeText( subtitle, maxLines: 1, minFontSize: 10, overflowReplacement: Text(tr("overflow_settings_subtitle")) ),
      value: currentValue,
      onChanged: updateValue,
      secondary: Column( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[icon] ),
    );
  }

  Widget _buildDropDownListTile(String title, String subtitle, String currentValue, List<String> values, Function updateValue, Icon icon) {
    return ListTile(
      title: Text(title),
      subtitle: AutoSizeText( subtitle, maxLines: 1, minFontSize: 10, overflowReplacement: Text(tr("overflow_settings_subtitle")) ),
      leading: Column( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[icon] ),
      trailing: DropdownButton<String>(
        value: currentValue,
        elevation: 16,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        underline: Container(
          height: 2,
          color: Theme.of(context).accentColor,
        ),
        onChanged: updateValue,
        items: values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBody(BuildContext context, lang) {
    return !_isPrefsLoaded
        ? Center( child: CircularProgressIndicator() )
        : Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: <Widget>[
                    if (!kIsWeb) _buildSwitchListTile(
                      tr("settings_location"),
                      tr("settings_location_description"),
                      _isPosition,
                          (newValue) {
                        prefs.setBool(_locationKey, newValue);
                        setState(() {
                          _isPosition = newValue;
                        });
                      },
                      const Icon(Icons.location_on),
                    ),
                    _buildDropDownListTile(
                      tr("settings_language"),
                      tr("settings_language_description"),
                      lang,
                      _languages,
                          (newValue) {
                        Locale newLocale = _getNewLocale(newValue, context);
                        EasyLocalization.of(context).locale = newLocale;
                      },
                      const Icon(Icons.language),
                    ),
                    _buildDropDownListTile(
                      tr("settings_units"),
                      tr("settings_units_description"),
                      _getDisplayUnits(_units),
                      _listUnits,
                          (newValue) {
                        prefs.setString(_unitsKey, _getUnits(newValue));
                        setState(() {
                          _units = _getUnits(newValue);
                        });
                      },
                      const Icon(Icons.whatshot),
                    )
                  ],
          ),
        ),
      ],
    );
  }

  Locale _getNewLocale(String newValue, BuildContext context) {
    return InternationalizationConstants.SUPPORTED_LOCALES.firstWhere( (locale) => locale.languageCode == newValue.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = EasyLocalization.of(context).locale;
    String _lang = currentLocale.languageCode.toUpperCase();

    final appBar = CustomAppBar(
        title: tr("settings_title"),
        isTabBar: false,
        context: context
    ).getAppBar();

    final navbar = CustomNavbar(
      title: 'My Weather',
      appBar: AppBar(),
    );

    if (kIsWeb) {
      return ScreenTypeLayout.builder(
        mobile: (BuildContext context) => Scaffold(
          appBar: appBar,
          drawer: MainDrawer(),
          body: _buildBody(context, _lang),
        ),
        desktop: (BuildContext context) => Scaffold(
          appBar: navbar,
          drawer: MainDrawer(),
          body: _buildBody(context, _lang),
        ),
      );
    } else {
      return Scaffold(
        appBar: appBar,
        drawer: MainDrawer(),
        body: _buildBody(context, _lang),
      );
    }

  }

  String _getUnits(String unitsDisplay) {
    final binding = {
      InternationalizationConstants.IMPERIAL_DISPLAY : InternationalizationConstants.IMPERIAL,
      InternationalizationConstants.METRIC_DISPLAY : InternationalizationConstants.METRIC
    };
    return binding[unitsDisplay];
  }

  String _getDisplayUnits(String units) {
    final binding = {
      InternationalizationConstants.IMPERIAL : InternationalizationConstants.IMPERIAL_DISPLAY,
      InternationalizationConstants.METRIC : InternationalizationConstants.METRIC_DISPLAY
    };
    return binding[units];
  }
}
