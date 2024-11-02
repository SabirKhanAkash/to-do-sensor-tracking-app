import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT
          )
        ''');

        db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data_id INTEGER,
            taskTitle TEXT,
            createdDate TEXT,
            status TEXT,
            FOREIGN KEY (data_id) REFERENCES data(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  Future<void> insertTaskToData(int dataId, Task task) async {
    final db = await database;

    await db.insert('tasks', {
      'data_id': dataId,
      'taskTitle': task.taskTitle,
      'createdDate': task.createdDate,
      'status': task.status,
    });
  }

  // Insert Data with tasks
  Future<int> insertData(Data data) async {
    final db = await database;

    int dataId = await db.insert('data', {'title': data.title});

    // Insert each task referencing the Data ID
    for (var task in data.taskList!) {
      await db.insert('tasks', {
        'data_id': dataId,
        'taskTitle': task.taskTitle,
        'createdDate': task.createdDate,
        'status': task.status
      });
    }

    return dataId;
  }

  // Fetch all Data and their tasks
  Future<List<Data>> getAllData() async {
    final db = await database;

    // Fetch all Data entries
    final List<Map<String, dynamic>> dataMaps = await db.query('data');
    List<Data> dataList = [];

    for (var dataMap in dataMaps) {
      int dataId = dataMap['id'];

      // Fetch associated tasks
      final List<Map<String, dynamic>> taskMaps =
          await db.query('tasks', where: 'data_id = ?', whereArgs: [dataId]);

      List<Task> tasks = taskMaps.map((taskMap) {
        return Task(
          id: taskMap['id'],
          dataId: taskMap['data_id'],
          taskTitle: taskMap['taskTitle'],
          createdDate: taskMap['createdDate'],
          status: taskMap['status'],
        );
      }).toList();

      Data data = Data(
        id: dataId,
        title: dataMap['title'],
        taskList: tasks,
      );
      dataList.add(data);
    }

    return dataList;
  }

  // Fetch tasks of a specific data
  Future<List<Task>> getTasksOfData(int dataID) async {
    final db = await database;

    // Fetch all Data entries
    final List<Map<String, dynamic>> dataMaps = await db.query('data');

    for (var dataMap in dataMaps) {
      int dataId = dataMap['id'];
      if (dataId == dataID) {
        // Fetch associated tasks
        final List<Map<String, dynamic>> taskMaps =
            await db.query('tasks', where: 'data_id = ?', whereArgs: [dataId]);

        List<Task> tasks = taskMaps.map((taskMap) {
          return Task(
            id: taskMap['id'],
            dataId: taskMap['data_id'],
            taskTitle: taskMap['taskTitle'],
            createdDate: taskMap['createdDate'],
            status: taskMap['status'],
          );
        }).toList();
        return tasks;
      }
    }
    return [];
  }

  // Update Task by taskId
  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete Task by taskId
  Future<void> deleteTask(int taskId) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  // Delete Data when all tasks are deleted
  Future<void> deleteDataIfNoTasks(int dataId) async {
    final db = await database;

    final taskCount = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tasks WHERE data_id = ?', [dataId]));

    if (taskCount == 0) {
      await db.delete(
        'data',
        where: 'id = ?',
        whereArgs: [dataId],
      );
    }
  }
}
