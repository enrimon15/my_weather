import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/database/db_helper.dart';
import 'package:my_weather/models/city_favorite.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

import '../favorites_screen.dart';

class FavoriteCard extends StatelessWidget {
  final CityFavorite favoriteCity;
  final BackgroundCard background;

  FavoriteCard(this.favoriteCity, this.background);

  @override
  Widget build(BuildContext context) {
    const white = Colors.white;
    const bold = FontWeight.bold;

    return Dismissible(
      key: ValueKey(favoriteCity.id), //it takes an unique key
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).errorColor,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 8),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(tr("fav_dialog_title")),
            content: Text(tr("fav_dialog_title")),
            actions: <Widget>[
              FlatButton(
                child: Text(tr("no")),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text(tr("yes")),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        DBHelper.delete(favoriteCity);
      },
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushReplacementNamed('/', arguments: {'name': favoriteCity.name, 'province': favoriteCity.province}),
        child: Card(
          elevation: 6,
          margin: EdgeInsets.symmetric(vertical: 12.5, horizontal: 8),
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
              title: AutoSizeText(
                '${favoriteCity.name}, ${favoriteCity.province}',
                style: TextStyle(color: white, fontWeight: bold),
                maxLines: 1, minFontSize: 10, overflowReplacement: Text(favoriteCity.name)
              ),
              subtitle: AutoSizeText(
                favoriteCity.condition,
                style: TextStyle(color: white, fontWeight: bold),
                maxLines: 1, minFontSize: 8, overflowReplacement: Text("next_days_overflow_condition"),
              ),
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
      ),
    );
  }

}
