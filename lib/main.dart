import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather/pages/favorites/favorites_screen.dart';
import 'package:my_weather/pages/info/info_screen.dart';
import 'package:my_weather/pages/outline/tabs/tabs_screen.dart';
import 'package:my_weather/pages/search/search_screen.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';
import 'theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setPreferredOrientations([ //allow only portrait screen
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'My Weather',
      theme: ThemeData(
        primarySwatch: ThemeColors.primaryColor, //#0D47A1
        accentColor: ThemeColors.tertiaryColor, //#FFC107
        secondaryHeaderColor: ThemeColors.secondaryColor, //#4FC3F7
        // muli , monserrat , comfortaa
        textTheme: GoogleFonts.ralewayTextTheme(textTheme), //global font (raleway)
        appBarTheme: AppBarTheme( //appbar font (quicksand)
            textTheme: ThemeData.light().textTheme.copyWith(
                title: GoogleFonts.quicksand(
                  textStyle: textTheme.title,
                  fontSize: 20,
                  color: Colors.white
                )
            )
        ),
      ),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => TabScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
        InfoScreen.routeName: (ctx) => InfoScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen(),
      },
      //onUnknownRoute:
    );
  }
}
