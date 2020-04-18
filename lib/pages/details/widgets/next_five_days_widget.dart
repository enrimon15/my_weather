import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
      title: AutoSizeText(tr("details_next_days"), maxLines: 2, minFontSize: 10, overflowReplacement: Text(tr("details_next_days_overflow")) ),
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
                title: AutoSizeText( days[i-1].day, maxLines: 1, minFontSize: 10, overflowReplacement: Text(days[i-1].day.split(' ')[0]) ),
                subtitle: AutoSizeText(
                  days[i-1].condition,
                  style: TextStyle(
                      letterSpacing: 0.5
                  ),
                  maxLines: 1,
                  minFontSize: 8,
                  overflowReplacement: Text(tr("next_days_overflow_condition")),
                ),
                trailing: Text(
                  days[i-1].temp.split(' ')[0] + '°',
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
