import 'package:my_weather/models/city_favorite.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static final String table = 'favorite_cities';
  static final String columnId = '_id';
  static final String columnName = 'name';
  static final String columnProvince = 'province';


  static Future<sql.Database> open() async {
    final dbPath = await sql.getDatabasesPath(); //get the db path in which it is stored (an app folder)
    //open db and pass it the path and the name of the db
    //if it is the first time that this code is executed this operation create the db, otherwise take the db already created
    return sql.openDatabase(
        path.join(dbPath, 'weather.db'),
        onCreate: (db, version) async { //a function that start when the db is created/opened
          //query to execute
          await db.execute('''
              CREATE TABLE $table(
                $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
                $columnName TEXT NOT NULL,
                $columnProvince TEXT NOT NULL)
          ''');
        },
        version: 1 //i specified which db version i want to open
    );
  }

  static Future<bool> insertCity(CityFavorite city) async {
    final db = await DBHelper.open();
    city.id = await db.insert(table, city.toMap());
    close(db);
    return city.id != null;
  }

  static Future<CityFavorite> getCity(int id) async {
    final db = await DBHelper.open();
    List<Map> maps = await db.query(
        table,
        columns: [columnId, columnName, columnProvince],
        where: '$columnId = ?',
        whereArgs: [id]
    );
    close(db);
    if (maps.length > 0) {
      return CityFavorite.fromMap(maps.first);
    }
    return null;
  }

  static Future<CityFavorite> checkIsFavorite(CityFavorite city) async {
    final db = await DBHelper.open();
    List<Map> maps = await db.query(
        table,
        columns: [columnId, columnName, columnProvince],
        where: '$columnName = ? and $columnProvince = ?',
        whereArgs: [city.name, city.province]
    );
    print(maps);
    close(db);
    if (maps.length > 0) {
      return CityFavorite.fromMap(maps.first);
    }
    return null;
  }

  static Future<List<CityFavorite>> getAllCities() async {
    final db = await DBHelper.open();
    List<Map<String, dynamic>> records = await db.query(table);
    print('db ' + records.toString());
    List<CityFavorite> allCities = [];
    records.forEach( (singleMap) {
      allCities.add(CityFavorite.fromMap(singleMap));
    });
    close(db);
    return allCities;
  }

  static Future<bool> delete(CityFavorite city) async {
    final db = await DBHelper.open();
    int result = await db.delete(table, where: '$columnId = ?', whereArgs: [city.id]);
    close(db);
    return result > 0 ;
  }

  static Future<int> update(CityFavorite city) async {
    final db = await DBHelper.open();
    int result = await db.update(
        table,
        city.toMap(),
        where: '$columnId = ?',
        whereArgs: [city.id]
    );
    close(db);
    return result;
  }

  static Future close(sql.Database db) async => db.close();

}

