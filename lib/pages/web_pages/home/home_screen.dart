import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/details/widgets/chart_temp_days_widget.dart';
import 'package:my_weather/pages/map/widgets/leaflet_map_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/card_details_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/chart_press_hum_days.dart';
import 'package:my_weather/pages/web_pages/home/widget/chart_wind_days.dart';
import 'package:my_weather/pages/web_pages/home/widget/current_weather_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/hours_datatables_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/chart_temp_hours_widget.dart';
import 'package:my_weather/pages/web_pages/home/widget/next_five_days_widget.dart';
import 'package:my_weather/pages/web_pages/outline/footer.dart';
import 'package:my_weather/providers/today_weather.dart';
import 'package:provider/provider.dart';
import 'package:my_weather/pages/web_pages/hover_utilities.dart';
import 'package:my_weather/providers/next_five_days_weather.dart';

class HomeWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final DateTime now = new DateTime.now();
    final intlLocale = EasyLocalization.of(context).locale.toString();
    final weatherProvider = Provider.of<TodayWeather>(context); //provider
    final todayWeather = weatherProvider.getTodayWeather;
    final currentWeather = weatherProvider.getCurrentWeather;
    final coords = weatherProvider.getCityCoords;
    final nextDays = Provider.of<NextFiveDaysWeather>(context).getFiveDaysWeather.days;
    final chartData = Provider.of<TodayWeather>(context).getChartData;

    void showSimpleCustomDialog(BuildContext context) {
      Dialog simpleDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 650.0,
          width: 700.0,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: ChartTempDays(nextDays)),
                    const SizedBox(width: 10),
                    Expanded(child: ChartTempHours(chartData.hours))
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: ChartWindDays(nextDays)),
                    const SizedBox(width: 10),
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
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              children: <Widget>[
                CardDetails(currentWeather),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton.icon(
                        onPressed: () => showSimpleCustomDialog(context),
                        icon: const Icon(Icons.insert_chart),
                        label: Text(tr("web_chart_text"))
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
                    const SizedBox(width: 40),
                    Expanded(
                      child: Container(
                        height: 400,
                        child: LeafletMapWidget(coords),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                HoursDatatable(todayWeather),
                const SizedBox(height: 70),
                NextFiveDaysWeb(),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
