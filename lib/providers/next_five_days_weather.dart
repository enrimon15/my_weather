import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/models/five_days_weather.dart';

class NextFiveDaysWeather with ChangeNotifier {
  bool _isFetching = false;
  bool _isFetchError = false;
  FiveDaysWeather _fiveDaysWeather = new FiveDaysWeather.emptyInitialize();

  Future<void> fetchData(String city, String prov) async {
    final url = 'http://192.168.1.51:3000/mock/weather/fivedays/city/$city/$prov';
    print(url);

    _isFetching = true;
    _isFetchError = false;
    notifyListeners();

    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse = response.body;
        _fiveDaysWeather = FiveDaysWeather.fromJson(json.decode(jsonResponse));

        _isFetching = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load today weather from server');
      }
    } catch (error) {
      print(error);
      _isFetchError = true;
      notifyListeners();
    }
  }

  FiveDaysWeather get getFiveDaysWeather => _fiveDaysWeather;

  bool get isFetching => _isFetching;

  bool get isFetchError => _isFetchError;
}

