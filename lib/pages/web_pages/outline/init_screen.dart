import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/show_alert_widget.dart';
import 'package:my_weather/pages/search/data_search.dart';
import 'package:my_weather/pages/web_pages/home/home_screen.dart';
import 'package:my_weather/pages/web_pages/outline/navbar/custom_navbar_web.dart';

class InitScreenWeb extends StatefulWidget {
  final Map<String, bool> _prerequisites;

  InitScreenWeb(this._prerequisites);

  @override
  _InitScreenWebState createState() => _InitScreenWebState();
}

class _InitScreenWebState extends State<InitScreenWeb> {
  @override
  Widget build(BuildContext context) {

    Map<String, bool> prerequisites = widget._prerequisites;

    final navbar = CustomNavbar(
      title: 'My Weather',
      appBar: AppBar(),
    );

    return Scaffold(
      appBar: navbar,
      body: _buildBody(context, prerequisites),
    );
  }

  Widget _buildBody(BuildContext context, Map<String, bool> prerequisites) {
    if (prerequisites['isErrorFetching']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("generic_error"),
        buttonContent: tr("try_again"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
      );
    }
    else if (!prerequisites['locationPermissionSettings']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_settings_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => showSearch(context: context, delegate: DataSearch()),
      );
    }
    else if (!prerequisites['locationPermissionApp']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_app_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => showSearch(context: context, delegate: DataSearch()),
      );
    }
    else if (prerequisites['isLoading']) {
      return Center(child: CircularProgressIndicator());
    } else {
      return HomeWeb();
    }
  }

}
