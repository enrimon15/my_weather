import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer_widget.dart';
import 'package:my_weather/pages/web_pages/outline/custom_navbar_web.dart';
import 'package:my_weather/services/service_locator.dart';
import 'package:my_weather/services/shared_preferences_service.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _languages = InternationalizationConstants.languages;
  List<String> _listUnits = InternationalizationConstants.LIST_UNITS_DISPLAY;
  final prefsService = locator<PrefsService>();

  bool _isPosition;
  String _units;


  @override
  void initState() {
    super.initState();
    _getSharedPrefs();
  }

  _getSharedPrefs() {
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

  Widget _buildBody(BuildContext context, lang) {
    return Column(
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
    );
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
        breakpoints: ScreenBreakpoints( //define the desktop breakpoint (tablet and watch isn't used)
          desktop: 800,
          tablet: 600,
          watch: 300,
        ),
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

  Locale _getNewLocale(String newValue, BuildContext context) {
    return InternationalizationConstants.SUPPORTED_LOCALES.firstWhere( (locale) => locale.languageCode == newValue.toLowerCase());
  }
}
