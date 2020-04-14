import 'package:flutter/cupertino.dart';

class InternationalizationConstants {
  static const String PREFS_LOCATION_KEY = 'location';
  static const String PREFS_METRIC_KEY = 'metric';
  static const String FAHRENHEIT = '°F';
  static const String CELSIUS = 'C°';
  static const List<String> ALL_METRICS = [FAHRENHEIT, CELSIUS];
  static const Locale ENGLISH = Locale('en', 'US');
  static const Locale ITALIAN = Locale('it', 'IT');
  static const List<Locale> SUPPORTED_LOCALES = [ENGLISH, ITALIAN];
  static List<String> languages = _getLanguages();

  static List<String> _getLanguages() {
    List<String> result = [];
    SUPPORTED_LOCALES.forEach( (locale) => result.add(locale.languageCode.toUpperCase()) );
    return result;
  }

}