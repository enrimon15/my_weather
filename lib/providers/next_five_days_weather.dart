import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/services/service_locator.dart';
import 'package:my_weather/services/shared_preferences_service.dart';
import 'package:my_weather/utilities/api_constants.dart';
import 'package:my_weather/utilities/localization_constants.dart';

class NextFiveDaysWeather with ChangeNotifier {
  FiveDaysWeather _fiveDaysWeather = new FiveDaysWeather.emptyInitialize();
  String _units = InternationalizationConstants.METRIC;

  Future<void> fetchData(String city, String prov, String lang) async {
    _units = locator<PrefsService>().getUnits();

    final url = '${ApiConstants.baseURL}/${ApiConstants.NEXT_DAYS}/$city/$prov/$lang/units=$_units/api-key=${ApiConstants.apiKey}';
    print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse = response.body;
        _fiveDaysWeather = FiveDaysWeather.fromJson(json.decode(jsonResponse));
        notifyListeners();
      } else {
        throw HttpException('Failed to load today weather from server');
      }
    } catch (error) {
      print('NextFiveDaysProvider: ' + error.toString());
      throw error;
    }
  }

  FiveDaysWeather get getFiveDaysWeather => _fiveDaysWeather;

  String get units => _units;
}

