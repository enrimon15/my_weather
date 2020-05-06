//this is an utility class to select the correct weather icon from a given weather condition
class WeatherIconService {
  final String _iconPath = 'assets/img/icons/';
  final String _iconPathMarker = 'assets/img/markers/';
  final String _iconPathMarkerIOS = 'assets/img/markers_ios/';

  final Map<String, String> _iconMappingIT = {
    "Sereno" : "sereno.png",
    "Soleggiato" : "soleggiato.png",
    "Cielo Coperto" : "cielocoperto.png",
    "Nuvoloso" : "nuvoloso.png",
    "Pioggia" : "pioggia.png",
    "Neve" : "neve.png"
  };

  final Map<String, String> _iconMappingEN = {
    "Clear" : "sereno.png",
    "Sunny" : "soleggiato.png",
    "Partly Cloudy" : "cielocoperto.png",
    "Cloudy" : "nuvoloso.png",
    "Rain" : "pioggia.png",
    "Snow" : "neve.png"
  };

  String selectIcon(String icon) {
    if (_iconMappingIT.containsKey(icon)) return _iconPath + _iconMappingIT[icon];
    else if (_iconMappingEN.containsKey(icon)) return _iconPath + _iconMappingEN[icon];
    else return null;
  }

  String selectIconMarker(String icon, isIos){
    String addMarker = 'marker.';
    List<String> splitted = [];

    if (_iconMappingIT.containsKey(icon)) splitted = _iconMappingIT[icon].split('.');
    else if (_iconMappingEN.containsKey(icon)) splitted = _iconMappingEN[icon].split('.');

    String basePath = isIos ? _iconPathMarkerIOS : _iconPathMarker;

    return basePath + splitted[0] + addMarker + splitted[1];
  }

}