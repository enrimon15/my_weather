import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_weather/models/city_search.dart';
import 'package:flutter/services.dart' show rootBundle;

class SearchCities with ChangeNotifier {
  List<CitySearch> _allCities = [];

  Future<void> fetchData() async {

    try {
      String jsonString = await rootBundle.loadString('assets/res/italy_cities.json');
      //print(jsonString);
      if(jsonString == null || jsonString.length <= 0) return;
      List<dynamic> listCities = json.decode(jsonString);
      if (listCities == null || listCities.length <= 0) return;
      _allCities = listCities.map<CitySearch>( (json) => CitySearch.fromJson(json) ).toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }

  }

  List<CitySearch> get getAllCities => _allCities;


}