import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/models/generic_weather.dart';

class TodayWeather with ChangeNotifier {
  var now = new DateTime.now().hour;
  bool _isFetching = false;
  bool _isFetchError = false;
  DayWeather _todayWeather = new DayWeather.emptyInitialize();
  GenericWeather _currentWeather = new GenericWeather.emptyInitialize();


  Future<void> fetchData(String city, String prov) async {
    final url = 'http://192.168.1.51:3000/mock/weather/today/city/$city/$prov';
    print(url);

    _isFetching = true;
    _isFetchError = false;
    notifyListeners();

    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        //Map<String, dynamic> jsonMap = jsonDecode(jsonResponse);
        _todayWeather = DayWeather.fromJson(json.decode(jsonResponse)); //parsing json response into my object
        _currentWeather = _todayWeather.hours.singleWhere((singleHour) => singleHour.hour == '$now:00').weather; //save the current weather
        //throw Exception('Failed to load today weather from server');
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

  GenericWeather get getCurrentWeather => _currentWeather;

  DayWeather get getTodayWeather => _todayWeather;

  bool get isFetching => _isFetching;

  bool get isFetchError => _isFetchError;

}