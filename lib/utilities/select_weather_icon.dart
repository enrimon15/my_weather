//this is an utility class to select the correct weather icon from a given weather condition
class WeatherIcon {
  static final String iconPath = 'assets/img/icons/';
  static final String iconPathMarker = 'assets/img/markers/';

  static final Map<String, String> iconMappingIT = {
    "Sereno" : "sereno.png",
    "Soleggiato" : "soleggiato.png",
    "Cielo Coperto" : "cielocoperto.png",
    "Nuvoloso" : "nuvoloso.png",
    "Pioggia" : "pioggia.png",
    "Neve" : "neve.png"
  };

  static final Map<String, String> iconMappingEN = {
    "Clear" : "sereno.png",
    "Sunny" : "soleggiato.png",
    "Partly Cloudy" : "cielocoperto.png",
    "Cloudy" : "nuvoloso.png",
    "Rain" : "pioggia.png",
    "Snow" : "neve.png"
  };

  static String selectIcon(String icon) {
    return iconPath + iconMappingIT[icon];
  }

  static String selectIconMarker(String icon){
    String addMarker = 'marker.';
    List<String> splitted = iconMappingIT[icon].split('.');
    return iconPathMarker + splitted[0] + addMarker + splitted[1];
  }

}