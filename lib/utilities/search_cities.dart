import 'dart:convert';
import 'package:my_weather/models/city_search.dart';
import 'package:flutter/services.dart' show rootBundle;

class SearchCitiesUtility {
  static List<CitySearch> allCities = [];

  static Future<void> fetchData() async {

    try {
      String jsonString = await rootBundle.loadString('assets/res/italy_cities.json');
      if(jsonString == null || jsonString.length <= 0) return;
      List<dynamic> listCities = json.decode(jsonString);
      if (listCities == null || listCities.length <= 0) return;
      allCities = listCities.map<CitySearch>( (json) => CitySearch.fromJson(json) ).toList();
    } catch (error) {
      print('error: ' + error.toString());
      throw error;
    }

  }


}