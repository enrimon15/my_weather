import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_weather/pages/favorites/favorites_screen.dart';
import 'package:my_weather/pages/info/info_screen.dart';
import 'package:my_weather/pages/outline/tabs/tabs_screen.dart';
import 'package:my_weather/pages/search/search_screen.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  SystemChrome.setPreferredOrientations([ //allow only portrait screen
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initializeDateFormatting('it_IT', null); //initialize dateFormat locale
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider( //wrap all into state manager (Provider)
      //declaration of providers class
      providers: [
        ChangeNotifierProvider<TodayWeather>(create: (_) => TodayWeather()),
        ChangeNotifierProvider<TodayWeather>(create: (_) => TodayWeather()),
      ],
      child: MaterialApp(
        title: 'My Weather',
        theme: ThemeData(
          primarySwatch: ThemeColors.primaryColor, //#0D47A1
          accentColor: ThemeColors.tertiaryColor, //#FFC107
          secondaryHeaderColor: ThemeColors.secondaryColor, //#4FC3F7 //mettere blue
          // muli , monserrat , comfortaa
          textTheme: GoogleFonts.ralewayTextTheme(textTheme), //global font (raleway)
          appBarTheme: AppBarTheme( //appbar font (quicksand)
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: GoogleFonts.quicksand( //different font for appbar
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
      ),
    );
  }
}
