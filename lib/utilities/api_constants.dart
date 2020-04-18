import 'package:global_configuration/global_configuration.dart';

class ApiConstants {
  static final apiKey = GlobalConfiguration().getString("CETEMPS_API_KEY");
  static final String baseURL = 'https://cetemps-weather.herokuapp.com';
}