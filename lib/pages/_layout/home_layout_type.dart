import 'package:flutter/material.dart';
import 'package:my_weather/pages/_layout/init_data.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/foundation.dart';

class HomeLayoutType extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      return ScreenTypeLayout.builder(
        breakpoints: ScreenBreakpoints( //define the desktop breakpoint (tablet and watch isn't used)
          desktop: 800,
          tablet: 600,
          watch: 300,
        ),
        mobile: (ctx) => InitData('mobile'),
        desktop: (ctx) => InitData('web'),
      );
    } else {
      return InitData('mobile');
    }

  }
}
