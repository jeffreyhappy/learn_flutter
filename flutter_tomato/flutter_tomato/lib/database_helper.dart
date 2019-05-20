
import 'package:flutter_tomato/tomato_task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  String path;

  final String TABLE_NAME = "tb_task";

//  _init() async {
//    var databasesPath = await getDatabasesPath();
//    path = join(databasesPath, 'demo.db');
//  }

  _getDB() async{
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'demo.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, task_desc TEXT, finish_time INTEGER)');
        });
    return database;
  }

  insert(String desc) async {
    Database database = await _getDB();
    await database.rawInsert("insert into $TABLE_NAME(task_desc,finish_time) values(?,?) ",[desc == null ? "" : desc,new DateTime.now().millisecondsSinceEpoch]);
    await database.close();
  }

   Future<List<TomatoTask>> getList() async{
    Database database = await _getDB();
    List<Map> maps = await database.query(TABLE_NAME,
      columns: ["id","task_desc","finish_time"]
    );
    List<TomatoTask> taskList = List();
    for(int i = 0 ; i < maps.length ; i++){
      taskList.add(TomatoTask.fromMap(maps[i]));
    }
    await database.close();
    return taskList;

  }



}