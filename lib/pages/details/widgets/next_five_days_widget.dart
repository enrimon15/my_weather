import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/models/five_days_weather.dart';
import 'package:my_weather/utilities/select_weather_icon.dart';

class NextFiveDays extends StatelessWidget {
  final List<Day> nextFiveDays;

  NextFiveDays(this.nextFiveDays);

  List<ExpandableItem> _getDays() {
    return List.generate(nextFiveDays.length, (int index) {
      return ExpandableItem(
        day: nextFiveDays[index].day,
        temp: nextFiveDays[index].weather.temperature,
        condition: nextFiveDays[index].weather.status,
        image: Image.asset(
          WeatherIcon.selectIcon(nextFiveDays[index].weather.status),
          height: 48,
        ),
      );
    });
  }


  Widget _buildHeader() {
    return ListTile(
      leading: Image.asset(
        'assets/img/calendar.png',
        height: 48,
      ),
      title: Text('Prossimi 5 giorni'),
    );
  }

  Widget _buildBody() {
    final List<ExpandableItem> days = _getDays();

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: days.length + 1,
        itemBuilder: (ctx, i) {
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Divider(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListTile(
                leading: days[i-1].image,
                title: Text(days[i-1].day),
                subtitle: Text(
                  days[i-1].condition,
                  style: TextStyle(
                      letterSpacing: 0.5
                  ),
                ),
                trailing: Text(
                  days[i-1].temp.substring(0,2) + '°',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 36
                    ),
                  ),
                ),
              ),
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ExpandablePanel(
          header: _buildHeader(),
          collapsed: null,
          expanded: _buildBody(),
          //hasIcon: true,
          //tapHeaderToExpand: true,
        ),
      ),

    );
  }
}

class ExpandableItem {
  final String day;
  final String temp;
  final String condition;
  final Image image;

  ExpandableItem({
    @required this.day,
    @required this.temp,
    @required this.condition,
    @required this.image,
  });
}
