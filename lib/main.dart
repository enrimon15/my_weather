import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_weather/pages/_layout/home_layout_type.dart';
import 'package:my_weather/pages/error_screen.dart';
import 'package:my_weather/pages/favorites/favorites_screen.dart';
import 'package:my_weather/pages/info/info_screen.dart';
import 'package:my_weather/pages/outline/tabs_screen.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';
import 'package:my_weather/providers/favorite_cities.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:my_weather/utilities/localization_constants.dart';
import 'package:my_weather/utilities/search_cities.dart';
import 'theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([ //allow only portrait screen
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GlobalConfiguration().loadFromAsset("secrets");
  await SearchCitiesUtility.fetchData();
  runApp( EasyLocalization(
    child: MyApp(),
    supportedLocales: InternationalizationConstants.SUPPORTED_LOCALES, //[ Locale('en', 'US'), Locale('it', 'IT') ],
    path: 'i18n',
  ));
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider( //wrap all into state manager (Provider)
      //declaration of providers class
      providers: [
        ChangeNotifierProvider<TodayWeather>(create: (_) => TodayWeather()),
        ChangeNotifierProvider<NextFiveDaysWeather>(create: (_) => NextFiveDaysWeather()),
        ChangeNotifierProvider<FavoriteCities>(create: (_) => FavoriteCities()),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate, //translates the basic text in material widgets
          GlobalWidgetsLocalizations.delegate, //translate the text direction (LTR/RTL)
          EasyLocalization.of(context).delegate, //it takes the json in i18n
        ],
        supportedLocales: EasyLocalization.of(context).supportedLocales,
        locale: EasyLocalization.of(context).locale,
        localeResolutionCallback: (locale, supportedLocales) => resolutionLocale(locale, supportedLocales),
        debugShowCheckedModeBanner: false,
        title: 'My Weather',
        theme: ThemeData(
          primarySwatch: ThemeColors.primaryColor, //#0D47A1
          accentColor: ThemeColors.tertiaryColor, //#FFC107
          secondaryHeaderColor: ThemeColors.secondaryColor, //#4FC3F7
          textTheme: GoogleFonts.ralewayTextTheme(textTheme), //global font (raleway)
          appBarTheme: AppBarTheme( ////different font for appbar (quicksand)
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: GoogleFonts.quicksand(
                    textStyle: textTheme.headline6,
                    fontSize: 20,
                    color: Colors.white
                  )
              )
          ),
        ),
        initialRoute: '/', // default is '/'
        routes: {
          '/': (ctx) => HomeLayoutType(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          FavoritesScreen.routeName: (ctx) => !kIsWeb ? FavoritesScreen() : ErrorScreen(),
          InfoScreen.routeName: (ctx) => InfoScreen(),
        },
        onUnknownRoute: (RouteSettings setting) {
          print(setting.name);
          return MaterialPageRoute(builder: (ctx) => ErrorScreen());
        }
      ),
    );
  }
}

//check if the current device locale is supported, if it's not supported set default locale
Locale resolutionLocale(locale, supportedLocales) {
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }
  //if the locale is not supported, use the first one (default english)
  return InternationalizationConstants.ENGLISH;
}
