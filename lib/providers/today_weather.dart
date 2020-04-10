import 'dart:convert';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/models/generic_weather.dart';

class TodayWeather with ChangeNotifier {
  var now = new DateTime.now().hour;
  DayWeather _todayWeather = new DayWeather.emptyInitialize();
  GenericWeather _currentWeather = new GenericWeather.emptyInitialize();
  CityFavorite _currentCity = new CityFavorite();
  Map<String,dynamic> _coords = {};


  Future<void> fetchData(String city, String prov) async {
    final url = 'http://192.168.1.51:3000/mock/weather/today/city/$city/$prov';
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        _todayWeather = DayWeather.fromJson(json.decode(jsonResponse)); //parsing json response into my object
        _currentWeather = _todayWeather.hours.singleWhere((singleHour) => singleHour.hour == '$now:00').weather; //save the current weather
        _currentCity = CityFavorite(name: _todayWeather.cityName, province: _todayWeather.cityProvince.substring(1,3));
        notifyListeners();
      } else {
        throw HttpException('Failed to load today weather from server');
      }
    } catch (error) {
        print(error);
        throw error;
    }
  }
  
  Map<String, double> getMinMaxTemp() {
    List<double> temperatures = [];
    Map<String,double> result = {};

    _todayWeather.hours.map( (singleHour) {
      double temp = double.parse(singleHour.weather.temperature.substring(0,2));
      temperatures.add(temp);
    }).toList();

    result["max"] = temperatures.reduce(max);
    result["min"] = temperatures.reduce(min);

    return result;
  }

  Future<void> fetchCoords() async {
    final String cityName = _todayWeather.cityName;
    final String cityProvince = _todayWeather.cityProvince.substring(1,3);
    final url = 'http://192.168.1.51:3000/mock/coords/city/$cityName/$cityProvince';
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        _coords = jsonDecode(jsonResponse);
        _coords['cityName'] = _todayWeather.cityName;
        _coords['condition'] = _currentWeather.status;
        _coords['temperature'] = _currentWeather.temperature;
        notifyListeners();
      } else {
        throw HttpException('Failed to load city coords from server');
      }
    } catch (error) {
      print('TodayWeatherProvider: ' + error);
      throw error;
    }
  }

  Map<String,dynamic> get getCityCoords => _coords;

  GenericWeather get getCurrentWeather => _currentWeather;

  DayWeather get getTodayWeather => _todayWeather;

  CityFavorite get getCurrentCity => _currentCity;

}