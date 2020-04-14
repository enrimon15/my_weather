import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/configuration_exception.dart';
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocationHelper {

  static Future<String> fetchLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(InternationalizationConstants.PREFS_LOCATION_KEY) == false) {
      throw ConfigurationException('NO LOCATION PERMISSION');
    }
    final locData = await Location().getLocation();

    final url = 'http://192.168.1.51:3000/mock/coords/getCity/${locData.latitude}/${locData.longitude}';
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        String jsonResponse =  response.body;
        Map<String, dynamic> jsonMap = jsonDecode(jsonResponse);
        return jsonMap['city'];
      } else {
        throw HttpException('Failed to load city by coords from server');
      }
    } catch (error) {
      throw error;
    }
  }

}