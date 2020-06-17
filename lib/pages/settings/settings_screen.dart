import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer_widget.dart';
import 'package:my_weather/services/service_locator.dart';
import 'package:my_weather/services/shared_preferences_service.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final prefsService = locator<PrefsService>();
  List<String> _languages = InternationalizationConstants.languages;
  List<String> _listUnits = InternationalizationConstants.LIST_UNITS_DISPLAY;

  bool _isPosition;
  String _units;


  @override
  void initState() {
    super.initState();
    _getSharedPrefs();
  }

  _getSharedPrefs() async {
    _isPosition = prefsService.getPosition();
    _units = prefsService.getUnits();
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                _buildSwitchListTile(
                  tr("settings_location"),
                  tr("settings_location_description"),
                  _isPosition,
                  (newValue) {
                    prefsService.setPosition(newValue);
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
                  tr("settings_units"),
                  tr("settings_units_description"),
                  InternationalizationConstants.getDisplayUnits(_units),
                  _listUnits,
                  (newValue) {
                    prefsService.setUnits(InternationalizationConstants.getUnits(newValue));
                    setState(() {
                      _units = InternationalizationConstants.getUnits(newValue);
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
