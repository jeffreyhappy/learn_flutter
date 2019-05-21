
import 'package:flutter_tomato/tomato_task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{


  String path;

  final String TABLE_NAME = "tb_task";
  static Database _database;
//  static DbHelper instance = DbHelper._internal();
//
//  Database database;
//
//  DbHelper._internal(){
//    _getDB().then((Database db){
//      database = db;
//    });
//  }
//
//  factory DbHelper(){
//    return instance;
//  }


//  _init() async {
//    var databasesPath = await getDatabasesPath();
//    path = join(databasesPath, 'demo.db');
//  }

  Future<Database> _getDB() async{
    if(_database == null){
      var databasesPath = await getDatabasesPath();
      path = join(databasesPath, 'demo.db');
      // open the database
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, task_desc TEXT, finish_time INTEGER)');
          });
      _database =  database;
    }

    return _database;
//    var databasesPath = await getDatabasesPath();
//    path = join(databasesPath, 'demo.db');
//    // open the database
//    Database database = await openDatabase(path, version: 1,
//        onCreate: (Database db, int version) async {
//          // When creating the db, create the table
//          await db.execute(
//              'CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, task_desc TEXT, finish_time INTEGER)');
//        });
//    return database;
  }

  insert(String desc) {
    _getDB().then((Database database){
       database.rawInsert("insert into $TABLE_NAME(task_desc,finish_time) values(?,?) ",[desc == null ? "" : desc,new DateTime.now().millisecondsSinceEpoch])
       .then((int){
//         database.close();
       });
    });

  }

   Future<List<TomatoTask>> getList() async{
    Database database = await _getDB();
    List<Map> maps = await database.query(TABLE_NAME,
      columns: ["id","task_desc","finish_time"],
        orderBy:"id desc"
    );
//    await database.close();

    List<TomatoTask> taskList = List();
    for(int i = 0 ; i < maps.length ; i++){
      taskList.add(TomatoTask.fromMap(maps[i]));
    }
    return taskList;

  }



}