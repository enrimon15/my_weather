import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather/exceptions/configuration_exception.dart';
import 'package:my_weather/exceptions/http_exception.dart';
import 'package:my_weather/utilities/api_constants.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {

  Future<String> fetchLocation() async {

    //check permission shared preferences status
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(InternationalizationConstants.PREFS_LOCATION_KEY) != null && prefs.getBool(InternationalizationConstants.PREFS_LOCATION_KEY) == false) {
      throw ConfigurationException('LOCATION PERMISSION PREFS NOT ENABLED');
    }

    Location location = new Location(); //location
    PermissionStatus _permissionGranted;
    bool _serviceEnabled;
    LocationData _locData;

    //check permission status
    _permissionGranted = await location.hasPermission().catchError((error) => throw ConfigurationException('UNABLE TO GET USER COORDINATES'));
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw ConfigurationException('LOCATION PERMISSION SETTINGS NOT ENABLED');
      }
    }
    //check service status
    _serviceEnabled = await location.serviceEnabled().catchError((error) => throw ConfigurationException('UNABLE TO GET USER COORDINATES'));
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw ConfigurationException('LOCATION SERVICE NOT ENABLED');
      }
    }
    //all permission is ok
    _locData = await location.getLocation().catchError( (error) {
      print('Unable to get location: ' + error.toString());
      throw ConfigurationException('UNABLE TO GET USER COORDINATES');
    } );

    final url = '${ApiConstants.baseURL}/${ApiConstants.COORDS_BY_CITY}/${_locData.latitude}/${_locData.longitude}/api-key=${ApiConstants.apiKey}';
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