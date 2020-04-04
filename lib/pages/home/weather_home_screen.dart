import 'package:flutter/material.dart';
import 'package:my_weather/pages/home/widgets/clipper_curved.dart';
import 'package:my_weather/pages/home/widgets/current_weather_widget.dart';
import 'package:my_weather/pages/home/widgets/hours_list_widget.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipPath(
          clipper: MyClipperCurved(),
          child: CurrentWeather(),
        ),
        HoursList(),
      ],
    );
  }
}
