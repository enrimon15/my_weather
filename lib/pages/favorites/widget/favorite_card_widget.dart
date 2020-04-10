import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

import '../favorites_screen.dart';

class FavoriteCard extends StatelessWidget {
  final CityFavorite favoriteCity;
  final BackgroundCard background;

  const FavoriteCard(this.favoriteCity, this.background);

  @override
  Widget build(BuildContext context) {
    final white = Colors.white;
    final bold = FontWeight.bold;

    return Dismissible(
      key: ValueKey(favoriteCity.id), //it takes an unique key
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).errorColor,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        elevation: 6,
        //margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(background.imagePath),
              fit: BoxFit.cover,
              alignment: background.alignment,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: Image.asset(
              WeatherIcon.selectIcon(favoriteCity.condition),
              height: 48,
            ),
            title: Text('${favoriteCity.name}, ${favoriteCity.province}', style: TextStyle(color: white, fontWeight: bold)),
            subtitle: Text(favoriteCity.condition, style: TextStyle(color: white, fontWeight: bold)),
            trailing: Text(
              favoriteCity.temperature,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 36,
                    color: white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//Navigator.of(contex).pushNamed('/', arguments: {'name': ..., 'province': ...})
