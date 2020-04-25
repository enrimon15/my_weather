import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/details/widgets/chart_temp_days_widget.dart';
import 'package:my_weather/pages/map/widgets/leaflet_map_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/chart_press_hum_days.dart';
import 'package:my_weather/pages/web_pages/home/widget/chart_wind_days.dart';
import 'package:my_weather/pages/web_pages/home/widget/current_details_card_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/current_weather_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/hours_datatables_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/chart_temp_hours_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/next_five_days_wisget.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';

class HomeWeb extends StatelessWidget {
  final DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    final intlLocale = EasyLocalization.of(context).locale.toString();
    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final todayWeather = weatherProvider.getTodayWeather;
    final currentWeather = weatherProvider.getCurrentWeather;
    final coords = weatherProvider.getCityCoords;
    final nextDays = Provider.of<NextFiveDaysWeather>(context).getFiveDaysWeather.days;

    Widget _buildCardDetails() {
      return LayoutBuilder(
        builder: (ctx, sizingInformation) {
          if (sizingInformation.maxWidth > 980) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CurrentDetails(tr("details_wind").toUpperCase(), currentWeather.wind, 'assets/img/drop.png', 280),
                CurrentDetails(tr("details_pressure").toUpperCase(), currentWeather.pressure, 'assets/img/speedometer.png', 280),
                CurrentDetails(tr("details_humidity").toUpperCase(), currentWeather.humidity, 'assets/img/drop.png', 280),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CurrentDetails(tr("details_wind").toUpperCase(), currentWeather.wind, 'assets/img/drop.png', 600),
                SizedBox(height: 20),
                CurrentDetails(tr("details_pressure").toUpperCase(), currentWeather.pressure, 'assets/img/speedometer.png', 600),
                SizedBox(height: 20),
                CurrentDetails(tr("details_humidity").toUpperCase(), currentWeather.humidity, 'assets/img/drop.png', 600),
              ],
            );
          }
        },
      );
    }

    void showSimpleCustomDialog(BuildContext context) {
      Dialog simpleDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 650.0,
          width: 700.0,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: ChartTempDays(nextDays)),
                    SizedBox(width: 10),
                    Expanded(child: ChartTempHours(todayWeather.hours))
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: ChartWindDays(nextDays)),
                    SizedBox(width: 10),
                    Expanded(child: ChartPressHumDays(nextDays)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      showDialog(context: context, builder: (BuildContext context) => simpleDialog);
    }

    return Scrollbar(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        shrinkWrap: true,
        children: <Widget>[
          _buildCardDetails(),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () => showSimpleCustomDialog(context),
                  icon: Icon(Icons.insert_chart),
                  label: Text('Grafici')
              ),
            ],
          ).showCursorOnHover,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: CurrentWeatherWeb(
                  todayWeather.cityName,
                  currentWeather,
                  '${DateFormat.EEEE(intlLocale).format(DateTime.now())} ${now.day}',
                  weatherProvider.getMinMaxTemp(),
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Container(
                  height: 400,
                  child: LeafletMapWidget(coords),
                ),
              )
            ],
          ),
          SizedBox(height: 50),
          HoursDatatable(todayWeather),
          SizedBox(height: 70),
          NextFiveDaysWeb()
        ],
      ),
    );
  }
}
