import 'package:news/src/resources/Provider.dart';
import 'package:news/src/resources/Repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../model/ItemModel.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider(){
    init();
  }

  Future<Database> init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "items.db");
    db=await openDatabase(
    path,
    version: 1,
    onCreate: (Database newDb, int version){
    
    newDb.execute("""Create table Items (
      Id Integer PRIMARY KEY,
      type TEXT,
      by TEXT,
      time INTEGER,
      text TEXT,
      parent INTEGER,
      kids BLOB,
      dead INTEGER,
      deleted INTEGER,
      url TEXT,
      score INTEGER,
      title TEXT,
      descendants INTEGER
    )""");
    });
    return db;
  }
  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps=await db.query("Items",columns: null, where:"id = ?",whereArgs: [id]);
    if(maps.length>0){
      return ItemModel.fromDb(maps.first);
    }
    throw Exception('Null');
  }
  
  @override
  addItem(ItemModel item) {
    db.insert("Items",item.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  clear() async {
      return db.delete("items");
  }

  @override
  Future<List<int>>fetchTopIds() {
    // TODO: implement fetchTopIds
    throw UnimplementedError();
  }
  
}
