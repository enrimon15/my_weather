import 'package:get_it/get_it.dart';
import 'package:my_weather/services/city_search_service.dart';
import 'package:my_weather/services/connectivity_service.dart';
import 'package:my_weather/services/icon_service.dart';
import 'package:my_weather/services/location_service.dart';
import 'package:my_weather/services/shared_preferences_service.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerSingleton(SearchCityService());
  locator.registerLazySingleton(() => WeatherIconService());
  locator.registerLazySingleton(() => ConnectionService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => PrefsService());
}