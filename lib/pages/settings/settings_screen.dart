import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/custom_appbar.dart';
import 'package:my_weather/pages/outline/drawer/drawer_widget.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> _languages = ['ITA', 'ENG'];
  bool _isPosition = false;
  String _lang = 'ITA';

  Widget _buildSwitchListTile(String title, String subTitle, bool currentValue, Function updateValue, Icon icon) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
      secondary: icon,
    );
  }

  Widget _buildDropDownListTile(String title, String subtitle, String currentValue, List<String> values, Function updateValue, Icon icon) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: icon,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Impostazioni',
          isTabBar: false,
          context: context
      ).getAppBar(),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                _buildSwitchListTile(
                    'Posizione',
                    'Consenso alla geolocalizzazione',
                    _isPosition,
                    (newValue) {
                      setState(() {
                        _isPosition = newValue;
                      });
                    },
                    const Icon(Icons.location_on),
                ),
                _buildDropDownListTile(
                    'Lingua',
                    'Scegli la lingua dell\'app',
                    _lang,
                    _languages,
                    (newValue) {
                      setState(() {
                        _lang = newValue;
                      });
                    },
                    const Icon(Icons.language),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
