import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

class DbManager {
  static final DbManager _instance = DbManager._internal();
  static Database? _database;

  DbManager._internal();

  factory DbManager() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE task (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data_id INTEGER,
      taskTitle TEXT,
      createdDate TEXT,
      status TEXT,
      FOREIGN KEY (data_id) REFERENCES data (id) ON DELETE CASCADE
    )
    ''');
  }

  Future<int> insertData(Data data) async {
    final db = await database;
    int dataId = await db.insert('data', {'title': data.title});

    for (Task task in data.taskList!) {
      await db.insert('task', {
        'data_id': dataId,
        'taskTitle': task.taskTitle,
        'createdDate': task.createdDate,
        'status': task.status
      });
    }
    return dataId;
  }

  Future<List<Data>> getAllData() async {
    final db = await database;

    final List<Map<String, dynamic>> dataResult = await db.query('data');
    final List<Data> dataList = [];

    for (Map<String, dynamic> dataRow in dataResult) {
      final List<Map<String, dynamic>> taskResult = await db.query(
        'task',
        where: 'data_id = ?',
        whereArgs: [dataRow['id']],
      );

      List<Task> tasks = taskResult.map((taskRow) => Task.fromJson(taskRow)).toList();

      Data data = Data(
        id: dataRow['id'],
        title: dataRow['title'],
        taskList: tasks,
      );
      dataList.add(data);
    }

    return dataList;
  }

  Future<int> updateData(Data data) async {
    final db = await database;

    await db.update('data', {'title': data.title}, where: 'id = ?', whereArgs: [data.id]);

    for (Task task in data.taskList!) {
      if (task.taskTitle != null) {
        await db.update('task', task.toJson(), where: 'data_id = ?', whereArgs: [data.id]);
      } else {
        await db.insert('task', {
          'data_id': data.id,
          'taskTitle': task.taskTitle,
          'createdDate': task.createdDate,
          'status': task.status
        });
      }
    }

    return data.id!;
  }

  Future<void> deleteData(int id) async {
    final db = await database;

    await db.delete('data', where: 'id = ?', whereArgs: [id]);
    await db.delete('task', where: 'data_id = ?', whereArgs: [id]);
  }
}
