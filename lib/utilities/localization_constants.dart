import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InternationalizationConstants {
  static const String PREFS_LOCATION_KEY = 'location';
  static const String PREFS_UNITS_KEY = 'units';
  static const String IMPERIAL = 'imperial';
  static const String METRIC = 'metric';
  static const String IMPERIAL_DISPLAY = '°F';
  static const String METRIC_DISPLAY = 'C°';
  static const List<String> ALL_UNITS = [IMPERIAL, METRIC];
  static const List<String> LIST_UNITS_DISPLAY = [IMPERIAL_DISPLAY, METRIC_DISPLAY];
  static const Locale ENGLISH = Locale('en', 'US');
  static const Locale ITALIAN = Locale('it', 'IT');
  static const List<Locale> SUPPORTED_LOCALES = [ENGLISH, ITALIAN];
  static List<String> languages = _getLanguages();

  static List<String> _getLanguages() {
    List<String> result = [];
    SUPPORTED_LOCALES.forEach( (locale) => result.add(locale.languageCode.toUpperCase()) );
    return result;
  }

  static String getUnits(String unitsDisplay) {
    final binding = {
      InternationalizationConstants.IMPERIAL_DISPLAY : InternationalizationConstants.IMPERIAL,
      InternationalizationConstants.METRIC_DISPLAY : InternationalizationConstants.METRIC
    };
    return binding[unitsDisplay];
  }

  static String getDisplayUnits(String units) {
    final binding = {
      InternationalizationConstants.IMPERIAL : InternationalizationConstants.IMPERIAL_DISPLAY,
      InternationalizationConstants.METRIC : InternationalizationConstants.METRIC_DISPLAY
    };
    return binding[units];
  }

}