import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:assignment/model/Engines.dart';
import 'package:assignment/model/Rocket.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/Mass.dart';
import '../rocket/rocket_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  late RocketProvider rocketProvider;
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'assignment.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE Rocket(id INTEGER PRIMARY KEY,country TEXT,company TEXT,flickr_images TEXT,'
              'mass TEXT,'
              'engines TEXT,'
              'wikipedia TEXT,'
              'description TEXT,'
              'rocket_id TEXT,'
              'rocket_name TEXT,'
              'rocket_type TEXT'
              ')');
          }
        );
  }

  createRocket(Rocket rocket) async {
    await deleteAllRockets();
    final db = await database;
    Map<String, dynamic> map = rocket.toJson();
    if( map['flickr_images'] != null){
      List<String> flickrImages = map['flickr_images'];
      map['flickr_images'] = flickrImages.join(",");
    }
    if (map['mass'] != null) {
      Mass mass = Mass.fromJson(map['mass']);
      String massEncodedString = json.encode(mass.toJson());
      map['mass'] = massEncodedString;
    }
    if (map['engines'] != null) {
      Engines engines = Engines.fromJson(map['engines']);
      String enginesEncodedString = json.encode(engines.toJson());
      map['engines'] = enginesEncodedString;
    }
    final id = await db?.insert('Rocket', map);
  }

  Future<int?> deleteAllRockets() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM Rocket');
    return res;
  }

  Future<List<Rocket>?> getAllRockets() async {
    final db = await database;
    final res = await db?.rawQuery("SELECT * FROM ROCKET");
    List<Rocket>? list= [];
    if(res != null) {
     for(int i=0; i< res.length; i++){
       var newMap = {...res[i]};
       if(newMap['flickr_images'] != null){
          final flickrImages =newMap['flickr_images'];
          if(flickrImages is String){
            List<String> flickerImagesList = flickrImages.split(",");
            newMap.remove('flickr_images');
            newMap['flickr_images'] = flickerImagesList;
            print(flickerImagesList);
          }
       }
       if (newMap['mass'] != null) {
         final massEncodedString =newMap['mass'];
         if(massEncodedString is String){
           Map<String, dynamic> map = json.decode(massEncodedString);
           newMap['mass'] = map;
         }
       }
       if (newMap['engines'] != null) {
         final enginesEncodedString =newMap['engines'];
         if(enginesEncodedString is String){
           Map<String, dynamic> map  = json.decode(enginesEncodedString);
           newMap['engines'] = map;
         }
       }
       Rocket rocket = Rocket.fromJson(newMap);
       list.add(rocket);
     }
    }
    return list;
  }

}