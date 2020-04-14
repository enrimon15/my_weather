import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';
import 'package:my_weather/utilities/data_convert_localization.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _languages = InternationalizationConstants.languages;
  List<String> _allMetrics = InternationalizationConstants.ALL_METRICS;
  String _metricKey = InternationalizationConstants.PREFS_METRIC_KEY;
  String _locationKey = InternationalizationConstants.PREFS_LOCATION_KEY;

  bool _isPosition;
  String _metric;
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
    _metric = prefs.getString(_metricKey) ?? InternationalizationConstants.CELSIUS;
  }

  Widget _buildSwitchListTile(String title, String subTitle, bool currentValue, Function updateValue, Icon icon) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
      secondary: Column( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[icon] ),
    );
  }

  Widget _buildDropDownListTile(String title, String subtitle, String currentValue, List<String> values, Function updateValue, Icon icon) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
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

  Locale _getNewLocale(String newValue, BuildContext context) {
    return InternationalizationConstants.SUPPORTED_LOCALES.firstWhere( (locale) => locale.languageCode == newValue.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = EasyLocalization.of(context).locale;
    String _lang = currentLocale.languageCode.toUpperCase();

    return Scaffold(
      appBar: CustomAppBar(
          title: tr("settings_title"),
          isTabBar: false,
          context: context
      ).getAppBar(),
      drawer: MainDrawer(),
      body: !_isPrefsLoaded
        ? Center( child: CircularProgressIndicator() )
        : Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                _buildSwitchListTile(
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
                  _lang,
                  _languages,
                      (newValue) {
                    Locale newLocale = _getNewLocale(newValue, context);
                    EasyLocalization.of(context).locale = newLocale;
                  },
                  const Icon(Icons.language),
                ),
                _buildDropDownListTile(
                  tr("settings_metric"),
                  tr("settings_metric_description"),
                  _metric,
                  _allMetrics,
                      (newValue) {
                    prefs.setString(_metricKey, newValue);
                    setState(() {
                      _metric = newValue;
                    });
                  },
                  const Icon(Icons.whatshot),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
