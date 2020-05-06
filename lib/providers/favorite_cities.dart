import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/services/service_locator.dart';
import 'package:my_weather/services/shared_preferences_service.dart';
import 'package:my_weather/utilities/api_constants.dart';
import 'package:my_weather/utilities/localization_constants.dart';

class FavoriteCities with ChangeNotifier {
  List<CityFavorite> _favoriteCities = [];
  String _units = InternationalizationConstants.METRIC;

  Future<void> fetchFavoriteCities(String lang) async {
    try{
      _favoriteCities = await DBHelper.getAllCities();
      await Future.forEach(_favoriteCities, (singleCity) async {
        singleCity = await fetchData(singleCity, lang);
      });
      notifyListeners();
    } catch (error) {
      print('DbFetch favorites_provider Exception:' + error.toString());
      throw error;
    }
  }

  Future<CityFavorite> fetchData(CityFavorite city, String lang) async {
    _units = locator<PrefsService>().getUnits();

    final url = '${ApiConstants.baseURL}/${ApiConstants.CURRENT}/${city.name}/${city.province}/$lang/units=$_units/api-key=${ApiConstants.apiKey}';
    print(url);

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        Map<String,dynamic> result = json.decode(jsonResponse);
        Map<String, dynamic> currentWeather = result['weather'];
        city.temperature = (currentWeather['currentTemperature'] as String).split(' ')[0] + '°';
        city.condition = (currentWeather['currentStatus'] as String);
        return city;
      } else {
        throw HttpException('Failed to load today weather from server');
      }
    } catch (error) {
      print('Fetch single favorite error: ' + error.toString());
      throw error;
    }
  }

  List<CityFavorite> get getCityList => _favoriteCities;

  String get units => _units;
}