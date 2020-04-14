import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/models/generic_weather.dart';

class DetailsCard extends StatelessWidget {
  final GenericWeather currentWeather;


  DetailsCard(this.currentWeather);

  List<DetailsItem> _getDetails() {
    List<DetailsItem> items = [];
    items.add(DetailsItem(
      title: tr("details_humidity"),
      content: currentWeather.humidity,
      img: Image.asset(
        'assets/img/drop.png',
        height: 48,
      )
    ));
    items.add(DetailsItem(title: 'DIVIDER'));
    items.add(DetailsItem(
        title: tr("details_pressure"),
        content: currentWeather.pressure,
        img: Image.asset(
          'assets/img/speedometer.png',
          height: 48,
        )
    ));
    items.add(DetailsItem(title: 'DIVIDER'));
    items.add(DetailsItem(
        title: tr("details_wind"),
        content: currentWeather.wind,
        img: Image.asset(
          'assets/img/wind.png',
          height: 48,
        )
    ));

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final details = _getDetails();
    
    return Card(
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: details.length,
            itemBuilder: (ctx, i) {
              if (details[i].title != 'DIVIDER') {
                return ListTile(
                  title: Text(details[i].title),
                  subtitle: Text(details[i].content),
                  trailing: details[i].img,
                );
              } else return Divider();
            }
        )
      ),
    );
  }
}


class DetailsItem {
  final String title;
  final String content;
  final Image img;

  DetailsItem({
    @required this.title,
    this.content,
    this.img,
  });
}