import 'dart:convert';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/models/generic_weather.dart';
import 'package:my_weather/utilities/localization_constants.dart';

class TodayWeather with ChangeNotifier {
  DayWeather _todayWeather = new DayWeather.emptyInitialize();
  GenericWeather _currentWeather = new GenericWeather.emptyInitialize();
  CityFavorite _currentCity = new CityFavorite();
  Map<String,dynamic> _coords = {};
  String _units = InternationalizationConstants.METRIC;
  final _apiKey = GlobalConfiguration().getString("CETEMPS_API_KEY");


  Future<void> fetchData(String city, String prov, String lang) async {
    String now = new DateTime.now().hour.toString();
    _units = await InternationalizationConstants.getUnits(); //get metric from shared preferences

    final url = 'http://192.168.1.51:3000/mock/weather/today/$city/$prov/$lang/units=$_units/api-key=$_apiKey';
    print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        _todayWeather = DayWeather.fromJson(json.decode(jsonResponse)); //parsing json response into my object
        now = now.length == 1 ? '0$now:00' : '$now:00';
        print(now);
        _currentWeather = _todayWeather.hours.singleWhere((singleHour) => singleHour.hour == now).weather; //save the current weather
        _currentCity = CityFavorite(name: _todayWeather.cityName, province: _todayWeather.cityProvince.substring(1,3));
        notifyListeners();
      } else {
        throw HttpException('Failed to load today weather from server');
      }
    } catch (error) {
        print('TodayWeatherProvider: ' + error.toString());
        throw error;
    }
  }
  
  Map<String, int> getMinMaxTemp() {
    List<double> temperatures = [];
    Map<String,int> result = {};

    _todayWeather.hours.map( (singleHour) {
      double temp = double.parse(singleHour.weather.temperature.split(' ')[0]);
      temperatures.add(temp);
    }).toList();

    result["max"] = (temperatures.reduce(max)).round();
    result["min"] = (temperatures.reduce(min)).round();

    return result;
  }

  Future<void> fetchCoords() async {
    final String cityName = _todayWeather.cityName;
    final String cityProvince = _todayWeather.cityProvince.substring(1,3);
    final url = 'http://192.168.1.51:3000/mock/coords/city/$cityName/$cityProvince/api-key=$_apiKey';
    print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
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
      print('TodayWeatherProvider coords: ' + error);
      throw error;
    }
  }

  Map<String,dynamic> get getCityCoords => _coords;

  GenericWeather get getCurrentWeather => _currentWeather;

  DayWeather get getTodayWeather => _todayWeather;

  CityFavorite get getCurrentCity => _currentCity;

  String get units => _units;

}