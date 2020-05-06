import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/models/day_weather.dart';
import 'package:my_weather/services/icon_service.dart';
import 'package:my_weather/services/service_locator.dart';

class HoursDatatable extends StatelessWidget {
  final DayWeather todayWeather;

  HoursDatatable(this.todayWeather);

  @override
  Widget build(BuildContext context) {
    final HoursDataSource _hoursDataSource = HoursDataSource(todayWeather.hours);
    final color = Theme.of(context).primaryColor;
    final double textSize = 16;

    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          Expanded(
            child: PaginatedDataTable(
              header: Text(tr("web_datatable_title")),
              source: _hoursDataSource,
              dataRowHeight: 65,
              rowsPerPage: 8,
              sortColumnIndex: 0,
              sortAscending: true,
              columns: [
                DataColumn(label: Text(tr("web_datatable_hour"), style: TextStyle(color: color, fontSize: textSize))),
                DataColumn(label: Text(tr("web_datatable_temp"), style: TextStyle(color: color, fontSize: textSize))),
                DataColumn(label: Text(tr("web_datatable_status"), style: TextStyle(color: color, fontSize: textSize))),
                DataColumn(label: Text(tr("web_datatable_wind"), style: TextStyle(color: color, fontSize: textSize))),
                DataColumn(label: Text(tr("web_datatable_press"), style: TextStyle(color: color, fontSize: textSize))),
                DataColumn(label: Text(tr("web_datatable_hum"), style: TextStyle(color: color, fontSize: textSize))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HoursDataSource extends DataTableSource {
  final List<Hour> _hours;
  int _selectCount = 0;
  final DateTime now = new DateTime.now();
  final iconService = locator<WeatherIconService>();

  HoursDataSource(this._hours);

  Widget _buildHourContainer(singleHour, backgroundColor, textColor, text) {
    return  Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.blue),
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(23),
            bottom: Radius.circular(23)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius:2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(text, style: TextStyle(color: textColor)),
          Image.asset(iconService.selectIcon(singleHour.weather.status), height: 32),
        ],
      ),
    );
  }

  @override
  DataRow getRow(int index) {
    final Hour singleHour = _hours[index];
    final _isNow = singleHour.hour.substring(0,2) == now.hour.toString();

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          !_isNow
          ? _buildHourContainer(singleHour, Colors.blue, Colors.white, singleHour.hour)
          : _buildHourContainer(singleHour, Colors.white70, Colors.blue, 'ORA')
        ),
        DataCell(
            Text(singleHour.weather.temperature)
        ),
        DataCell(
            Text(singleHour.weather.status)
        ),
        DataCell(
            Text(singleHour.weather.wind)
        ),
        DataCell(
            Text(singleHour.weather.pressure)
        ),
        DataCell(
            Text(singleHour.weather.humidity)
        )
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _hours.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => _selectCount;

}
