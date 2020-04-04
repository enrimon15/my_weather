//this is an utility class to select the correct weather icon from a given weather condition
class WeatherIcon {
  static final String iconPath = 'assets/img/icons/';
  static final Map<String, String> iconMapping = {
    "Sereno" : "sereno.png",
    "Soleggiato" : "soleggiato.png",
    "Cielo Coperto" : "cielocoperto.png",
    "Nuvoloso" : "nuvoloso.png",
    "Pioggia" : "pioggia.png",
    "Neve" : "neve.png"
  };

  static String selectIcon(String icon){
    return iconPath + iconMapping[icon];
  }

}