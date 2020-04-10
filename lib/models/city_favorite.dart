import 'package:my_weather/database/db_helper.dart';

class CityFavorite {
  int id;
  String name;
  String province;
  String condition;
  String temperature;

  CityFavorite({
    this.name,
    this.province,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DBHelper.columnName: name,
      DBHelper.columnProvince: province,
    };
    if (id != null) {
      map[DBHelper.columnId] = id;
    }
    return map;
  }

  CityFavorite.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.columnId];
    name = map[DBHelper.columnName];
    province = map[DBHelper.columnProvince];
  }

}