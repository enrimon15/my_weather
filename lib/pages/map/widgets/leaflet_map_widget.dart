import 'package:flutter/material.dart';
import 'package:my_weather/services/icon_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:my_weather/services/service_locator.dart';

class LeafletMapWidget extends StatelessWidget {
  final iconService = locator<WeatherIconService>();
  final Map<String,dynamic> coords;

  LeafletMapWidget(this.coords);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: new MapOptions(
        minZoom: 5.0,
        center: LatLng(coords['lat'], coords['lon']),
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(coords['lat'], coords['lon']),
              builder: (ctx) =>
                  Tooltip(
                    message: '${coords['cityName']}, ${coords['temperature']}',
                    child: Image.asset(
                      iconService.selectIconMarker(coords['condition'], false),
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
