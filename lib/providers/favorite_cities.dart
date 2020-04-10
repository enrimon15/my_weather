import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:http/http.dart' as http;

class FavoriteCities with ChangeNotifier {
  List<CityFavorite> _favoriteCities = [];

  Future<void> fetchFavoriteCities() async {
    try{
      _favoriteCities = await DBHelper.getAllCities();
      await Future.forEach(_favoriteCities, (singleCity) async {
        singleCity = await fetchData(singleCity);
      });
      notifyListeners();
    } catch (error) {
      print('DbFetch Exception:' + error);
      throw error;
    }
  }

  Future<CityFavorite> fetchData(CityFavorite city) async {
    final url = 'http://192.168.1.51:3000/mock/weather/current/city/${city.name}/${city.province}';
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        print('provider ' + jsonResponse);
        Map<String,dynamic> result = json.decode(jsonResponse);
        Map<String, dynamic> currentWeather = result['weather'];
        city.temperature = (currentWeather['currentTemperature'] as String).substring(0,2) + '°';
        city.condition = (currentWeather['currentStatus'] as String);
        return city;
      } else {
        throw HttpException('Failed to load today weather from server');
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  List<CityFavorite> get getCityList => _favoriteCities;
}