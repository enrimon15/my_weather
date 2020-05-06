import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:my_weather/models/city_search.dart';

class SearchCityService {
  List<CitySearch> _allCities = [];

  Future<void> fetchData() async {

    try {
      String jsonString = await rootBundle.loadString('assets/res/italy_cities.json');
      if(jsonString == null || jsonString.length <= 0) return;
      List<dynamic> listCities = json.decode(jsonString);
      if (listCities == null || listCities.length <= 0) return;
      _allCities = listCities.map<CitySearch>( (json) => CitySearch.fromJson(json) ).toList();
    } catch (error) {
      print('error: ' + error.toString());
      throw error;
    }

  }

  List<CitySearch> get getCities => _allCities;

}