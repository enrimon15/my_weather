import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/utilities/localization_constants.dart';

class NextFiveDaysWeather with ChangeNotifier {
  FiveDaysWeather _fiveDaysWeather = new FiveDaysWeather.emptyInitialize();
  String _units = InternationalizationConstants.METRIC;
  final _apiKey = GlobalConfiguration().getString("CETEMPS_API_KEY");

  Future<void> fetchData(String city, String prov, String lang) async {
    _units = await InternationalizationConstants.getUnits();

    final url = 'http://192.168.1.51:3000/mock/weather/fivedays/$city/$prov/$lang/units=$_units/api-key=$_apiKey';
    print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse = response.body;
        _fiveDaysWeather = FiveDaysWeather.fromJson(json.decode(jsonResponse));
        notifyListeners();
      } else {
        throw HttpException('Failed to load today weather from server');
      }
    } catch (error) {
      print('NextFiveDaysProvider: ' + error);
      throw error;
    }
  }

  FiveDaysWeather get getFiveDaysWeather => _fiveDaysWeather;

  String get units => _units;
}

