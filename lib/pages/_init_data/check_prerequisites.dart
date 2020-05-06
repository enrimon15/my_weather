import 'package:app_settings/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/outline/show_alert_widget.dart';
import 'package:my_weather/pages/search/data_search.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';

class CheckPrerequisites extends StatelessWidget {
  final Map<String, bool> prerequisites;
  final Widget screen;
  final TabBarView tabBarView;
  final bool isTabBar;

  CheckPrerequisites({
    @required this.prerequisites,
    @required this.isTabBar,
    this.tabBarView,
    this.screen
  });

  @override
  Widget build(BuildContext context) {
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
        secondButtonContent: kIsWeb
            ? tr("search_hint")
            : tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: kIsWeb
            ? () => showSearch(context: context, delegate: DataSearch())
            : () => AppSettings.openLocationSettings(),
      );
    }
    else if (!prerequisites['locationPermissionPrefs']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_prefs_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: () => Navigator.of(context).pushReplacementNamed(SettingsScreen.routeName),
      );
    }
    else if (!prerequisites['locationPermissionApp']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("location_app_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: kIsWeb
            ? tr("search_hint")
            : tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: kIsWeb
            ? () => showSearch(context: context, delegate: DataSearch())
            : () => AppSettings.openAppSettings(),
      );
    }
    else if (!prerequisites['isConnectivity']) {
      return ShowAlert(
        title: 'Oops..',
        content: tr("connection_error"),
        buttonContent: tr("try_again"),
        secondButtonContent: kIsWeb ? null : tr("settings_button"),
        onTap: () => Navigator.of(context).pushReplacementNamed('/'),
        secondOnTap: kIsWeb ? null : () => AppSettings.openWIFISettings(),
      );
    }
    else if (prerequisites['isLoading']) {
      return const Center(child: CircularProgressIndicator());
    }

    else if (isTabBar) {
      return tabBarView;
    } else {
      return screen;
    }
  }
}
