import 'dart:convert';
import "dart:math";
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/chart_data.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/models/generic_weather.dart';
import 'package:my_weather/services/service_locator.dart';
import 'package:my_weather/services/shared_preferences_service.dart';
import 'package:my_weather/utilities/api_constants.dart';
import 'package:my_weather/utilities/localization_constants.dart';

class TodayWeather with ChangeNotifier {
  DayWeather _todayWeather = new DayWeather.emptyInitialize();
  ChartData _chartData = new ChartData.emptyInitialize();
  GenericWeather _currentWeather = new GenericWeather.emptyInitialize();
  CityFavorite _currentCity = new CityFavorite();
  Map<String,dynamic> _coords = {};
  String _units = InternationalizationConstants.METRIC;


  Future<void> fetchData(String city, String prov, String lang) async {
    String now = new DateTime.now().hour.toString();
    _units = locator<PrefsService>().getUnits(); //get metric from shared preferences


    final url = '${ApiConstants.baseURL}/${ApiConstants.TODAY}/$city/$prov/$lang/units=$_units/api-key=${ApiConstants.apiKey}';
    //print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        _todayWeather = DayWeather.fromJson(json.decode(jsonResponse)); //parsing json response into my object
        now = now.length == 1 ? '0$now:00' : '$now:00';
        _currentWeather = _todayWeather.hours.singleWhere((singleHour) => singleHour.hour == now).weather; //save the current weather
        _currentCity = CityFavorite(name: _todayWeather.cityName, province: _todayWeather.cityProvince.substring(1,3)); //get current city (for favorites)

        await fetchCoords(); //fetch coords of city for maps
        await fetchChartData(_units, lang);

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
    final url = '${ApiConstants.baseURL}/${ApiConstants.COORDS}/$cityName/$cityProvince/api-key=${ApiConstants.apiKey}';
    //print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        _coords = jsonDecode(jsonResponse);
        _coords['cityName'] = _todayWeather.cityName;
        _coords['condition'] = _currentWeather.status;
        _coords['temperature'] = _currentWeather.temperature;
      } else {
        throw HttpException('Failed to load city coords from server');
      }
    } catch (error) {
      print('TodayWeatherProvider coords: ' + error.toString());
      throw error;
    }
  }

  Future<void> fetchChartData(String units, String lang) async {
    final String cityName = _todayWeather.cityName;
    final String cityProvince = _todayWeather.cityProvince.substring(1,3);

    final url = '${ApiConstants.baseURL}/${ApiConstants.CHART}/$cityName/$cityProvince/$lang/units=$_units/api-key=${ApiConstants.apiKey}';
    print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        _chartData = ChartData.fromJson(json.decode(jsonResponse)); //parsing json response into my object
      } else {
        throw HttpException('Failed to load chart data from server');
      }
    } catch (error) {
      print('TodayWeatherProvider chart data: ' + error.toString());
      throw error;
    }
  }

  Map<String,dynamic> get getCityCoords => _coords;

  GenericWeather get getCurrentWeather => _currentWeather;

  DayWeather get getTodayWeather => _todayWeather;

  CityFavorite get getCurrentCity => _currentCity;

  ChartData get getChartData => _chartData;

  String get units => _units;

}