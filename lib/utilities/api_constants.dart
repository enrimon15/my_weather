import 'package:global_configuration/global_configuration.dart';

class ApiConstants {
  static final apiKey = GlobalConfiguration().getString("CETEMPS_API_KEY");
  static final String baseURL = 'https://cetemps-weather.herokuapp.com';
  /*static const String TODAY = 'mock/weather/today';
  static const String COORDS = 'mock/coords/city';
  static const String NEXT_DAYS = 'mock/weather/fivedays';
  static const String CURRENT = 'mock/weather/current';
  static const String COORDS_BY_CITY = 'mock/coords/getCity';
  static const String CHART = 'mock/weather/chart';*/

  //static final String baseURL = 'http://192.168.1.51:3000';

  static const TODAY = 'weather/today';
  static const String CHART = 'weather/today/chart';
  static const String COORDS = 'coords/city';
  static const String NEXT_DAYS = 'weather/fivedays';
  static const String CURRENT = 'weather/current';
  static const String COORDS_BY_CITY = 'coords/getCity';
}