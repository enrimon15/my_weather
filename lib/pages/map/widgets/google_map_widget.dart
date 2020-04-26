import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class GoogleMapWidget extends StatefulWidget {
  final Map<String,dynamic> coords;

  GoogleMapWidget(this.coords);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  BitmapDescriptor customIcon;

  _createMarker(context, String img) {
    if (customIcon == null) {
      bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, WeatherIcon.selectIconMarker(img, isIOS))
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _createMarker(context, widget.coords['condition']);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          (widget.coords['lat'] as double),
          (widget.coords['lon'] as double),
        ),
        zoom: 13,
      ),
      markers: {
        Marker(
          markerId: MarkerId('m1'),
          position: LatLng(
            (widget.coords['lat'] as double),
            (widget.coords['lon'] as double),
          ),
          infoWindow: InfoWindow(
            title: widget.coords['cityName'],
            snippet: widget.coords['temperature'],
          ),
          icon: customIcon != null ? customIcon : null,
        )
      },
    );
  }
}

/*

 */
