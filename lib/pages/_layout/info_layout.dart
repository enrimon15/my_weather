import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/error_screen.dart';
import 'package:my_weather/pages/info/info_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InfoLayout extends StatelessWidget {
  static const routeName = '/info';

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return ScreenTypeLayout.builder(
        breakpoints: ScreenBreakpoints( //define the desktop breakpoint (tablet and watch isn't used)
          desktop: 800,
          tablet: 600,
          watch: 300,
        ),
        mobile: (ctx) => InfoScreen(),
        desktop: (ctx) => ErrorScreen(),
      );
    } else {
      return InfoScreen();
    }
  }
}
