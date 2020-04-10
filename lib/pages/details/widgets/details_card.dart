import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_weather/models/generic_weather.dart';

class DetailsCard extends StatelessWidget {
  final GenericWeather currentWeather;


  DetailsCard(this.currentWeather);

  List<DetailsItem> _getDetails() {
    List<DetailsItem> items = [];
    items.add(DetailsItem(
      title: 'Umidità',
      content: currentWeather.humidity,
      img: Image.asset(
        'assets/img/drop.png',
        height: 48,
      )
    ));
    items.add(DetailsItem(title: 'DIVIDER'));
    items.add(DetailsItem(
        title: 'Pressione',
        content: currentWeather.pressure,
        img: Image.asset(
          'assets/img/speedometer.png',
          height: 48,
        )
    ));
    items.add(DetailsItem(title: 'DIVIDER'));
    items.add(DetailsItem(
        title: 'Vento',
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

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        SizedBox(height: 15,),
        Text('ciao'),
        Text('ciao'),
        Text('ciao'),
        Text('ciao'),
        Text('ciao'),
        Text('ciao'),
        Text('ciao'),
      ],
    );
  }
}


/*


        

 */


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
