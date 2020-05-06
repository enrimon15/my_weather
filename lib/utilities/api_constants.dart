import 'package:global_configuration/global_configuration.dart';

class ApiConstants {
  static final apiKey = GlobalConfiguration().getString("CETEMPS_API_KEY");
  static const String baseURL = 'https://cetemps-weather.herokuapp.com';
  //static final String baseURL = 'http://192.168.1.51:3000';
  static const String TODAY = 'mock/weather/today';
  static const String COORDS = 'mock/coords/city';
  static const String NEXT_DAYS = 'mock/weather/fivedays';
  static const String CURRENT = 'mock/weather/current';
}