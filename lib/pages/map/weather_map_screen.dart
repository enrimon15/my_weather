import 'package:flutter/material.dart';
import 'package:my_weather/pages/map/widgets/google_map_widget.dart';
import 'package:my_weather/pages/map/widgets/leaflet_map_widget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Maps extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TodayWeather>(context, listen: false).fetchCoords(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center( child: Text(tr("map_error")) );
        } else {
            return Consumer<TodayWeather>(
              builder: (ctx, todayWeather, ch) {
                return //GoogleMapWidget(todayWeather.getCityCoords);
                LeafletMapWidget(todayWeather.getCityCoords);
              }
            );
        }
        }
    );
  }
}