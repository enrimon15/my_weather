import 'package:my_weather/utilities/localization_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  SharedPreferences _prefs;

  Future<void> getPrefsInstance() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  String getUnits() {
    return _prefs.getString(InternationalizationConstants.PREFS_UNITS_KEY) ?? InternationalizationConstants.METRIC;
  }

  bool getPosition() {
    return _prefs.getBool(InternationalizationConstants.PREFS_LOCATION_KEY) ?? true;
  }

  setPosition(bool newValue) {
    _prefs.setBool(InternationalizationConstants.PREFS_LOCATION_KEY, newValue);
  }

  setUnits(String newValue) {
    _prefs.setString(InternationalizationConstants.PREFS_UNITS_KEY, newValue);
  }
}