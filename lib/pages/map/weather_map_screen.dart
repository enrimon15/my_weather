import 'package:flutter/material.dart';
import 'package:my_weather/pages/map/widgets/google_map_widget.dart';
import 'package:my_weather/pages/map/widgets/leaflet_map_widget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';

class Maps extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final coords = Provider.of<TodayWeather>(context, listen: false)
                  .getCityCoords;
    return GoogleMapWidget(coords);
  }
}