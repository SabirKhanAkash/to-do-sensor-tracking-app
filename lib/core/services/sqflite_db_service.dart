import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_sensor_tracking_app/core/services/log_service.dart';
import 'package:to_do_sensor_tracking_app/core/services/notification_service.dart';
import 'package:to_do_sensor_tracking_app/core/services/shared_pref_service.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/utils/format_date.dart';

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
            notificationEnabled INTEGER,
            note TEXT,
            status TEXT,
            FOREIGN KEY (data_id) REFERENCES data(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  /**
   * CRUD on Data
   */
  Future<int> insertData(Data data) async {
    final db = await database;

    int dataId = await db.insert('data', {'title': data.title});

    for (var task in data.taskList!) {
      await db.insert('tasks', {
        'data_id': dataId,
        'taskTitle': task.taskTitle,
        'createdDate': task.createdDate,
        'notificationEnabled': task.notificationEnabled,
        'note': task.note ?? "",
        'status': task.status
      });
    }

    return dataId;
  }

  Future<List<Data>> getAllData() async {
    final db = await database;

    final List<Map<String, dynamic>> dataMaps = await db.query('data');
    List<Data> dataList = [];

    int completedDataCount = 0;
    int incompleteDataCount = 0;
    int tasksWithNotificationTodayCount = 0;

    String todayFormatted = formatDate(DateTime.now());

    for (var dataMap in dataMaps) {
      int dataId = dataMap['id'];

      final List<Map<String, dynamic>> taskMaps =
          await db.query('tasks', where: 'data_id = ?', whereArgs: [dataId]);

      List<Task> tasks = taskMaps.map((taskMap) {
        return Task(
          id: taskMap['id'],
          dataId: taskMap['data_id'],
          taskTitle: taskMap['taskTitle'],
          createdDate: taskMap['createdDate'],
          notificationEnabled: taskMap['notificationEnabled'],
          note: taskMap['note'] ?? "",
          status: taskMap['status'],
        );
      }).toList();

      Data data = Data(
        id: dataId,
        title: dataMap['title'],
        taskList: tasks,
      );
      dataList.add(data);

      bool allTasksCompleted =
          tasks.isNotEmpty && tasks.every((task) => task.status == 'completed');

      if (allTasksCompleted) {
        completedDataCount++;
      } else {
        incompleteDataCount++;
      }

      await SharedPreference().setInt("completedDataCount", completedDataCount);
      await SharedPreference().setInt("incompleteDataCount", incompleteDataCount);

      int todayTaskCount = tasks
          .where((task) =>
              task.notificationEnabled == 1 &&
              task.createdDate == todayFormatted &&
              task.status != 'completed')
          .length;

      tasksWithNotificationTodayCount += todayTaskCount;
    }
    if (tasksWithNotificationTodayCount > 0) {
      NotificationService().showNotification(
          "Due Date Alert", "You have got $tasksWithNotificationTodayCount task(s) due today");
    }

    return dataList;
  }

  Future<void> updateData(Data data) async {
    final db = await database;

    await db.update(
      'data',
      {'title': data.title},
      where: 'id = ?',
      whereArgs: [data.id],
    );

    for (var task in data.taskList ?? []) {
      int affectedRows = await db.update(
        'tasks',
        {
          'taskTitle': task.taskTitle,
          'createdDate': task.createdDate,
          'notificationEnabled': task.notificationEnabled,
          'note': task.note ?? "",
          'status': task.status,
        },
        where: 'id = ? AND data_id = ?',
        whereArgs: [task.id, data.id],
      );

      if (affectedRows == 0) {
        await db.insert(
          'tasks',
          {
            'data_id': data.id,
            'taskTitle': task.taskTitle,
            'createdDate': task.createdDate,
            'notificationEnabled': task.notificationEnabled,
            'note': task.note ?? "",
            'status': task.status,
          },
        );
      } else {
        Log.create(Level.info, "Updated task with id: ${task.id}");
      }
    }
  }

  Future<void> deleteData(int dataId) async {
    final db = await database;
    await db.delete(
      'data',
      where: 'id = ?',
      whereArgs: [dataId],
    );
  }

  /**
   * RD on Task of a Data
   */
  Future<List<Task>> getTasksOfData(int dataID) async {
    final db = await database;

    final List<Map<String, dynamic>> dataMaps = await db.query('data');

    for (var dataMap in dataMaps) {
      int dataId = dataMap['id'];
      if (dataId == dataID) {
        final List<Map<String, dynamic>> taskMaps =
            await db.query('tasks', where: 'data_id = ?', whereArgs: [dataId]);

        List<Task> tasks = taskMaps.map((taskMap) {
          return Task(
            id: taskMap['id'],
            dataId: taskMap['data_id'],
            taskTitle: taskMap['taskTitle'],
            createdDate: taskMap['createdDate'],
            notificationEnabled: taskMap['notificationEnabled'],
            note: taskMap['note'] ?? "",
            status: taskMap['status'],
          );
        }).toList();
        return tasks;
      }
    }
    return [];
  }

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

  Future<void> deleteTask(int taskId) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
