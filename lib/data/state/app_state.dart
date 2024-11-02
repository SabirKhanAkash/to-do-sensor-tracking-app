import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

class AppState extends ChangeNotifier {
  bool _isTaskChecked = false;
  bool _isNotificationEnabled = false;
  bool _isTaskTextNotEmpty = false;
  String _selectedDate = "";
  List<Data> _dataList = [];
  List<Task> _taskList = [];

  List<Task> _tasks = [];

  List<Data> get dataList => _dataList;

  List<Task> get taskList => _taskList;

  String get selectedDate => _selectedDate;

  List<Task> get tasks => _tasks;

  bool get isTaskChecked => _isTaskChecked;

  bool get isNotificationEnabled => _isNotificationEnabled;

  bool get isTaskTextNotEmpty => _isTaskTextNotEmpty;

  void setDate(String formattedPickedDate) {
    _selectedDate = formattedPickedDate;
    notifyListeners();
  }

  Future<void> loadData() async {
    _dataList = await DBHelper().getAllData();
    notifyListeners();
  }

  Future<void> loadTasksOfData(int dataId) async {
    _taskList = await DBHelper().getTasksOfData(dataId);
    notifyListeners();
  }

  void getTaskOfData(Data data) {
    _tasks.addAll(data as Iterable<Task>);
    notifyListeners();
  }

  Future<void> addData(Data data) async {
    await DBHelper().insertData(data);
    await loadData();
  }

  Future<void> addTaskToData(int dataId, Task task) async {
    await DBHelper().insertTaskToData(dataId, task);
    await loadData();
  }

  Future<void> updateTask(Task task) async {
    await DBHelper().updateTask(task);
    await loadData();
  }

  Future<void> deleteTask(int taskId, int dataId) async {
    await DBHelper().deleteTask(taskId);
    await DBHelper().deleteDataIfNoTasks(dataId);
    await loadData();
  }

  Future<void> deleteData(int dataId) async {
    await DBHelper().deleteDataIfNoTasks(dataId);
    await loadData();
  }

  void toggleTaskAddCheckBoxVisibility() {
    _isTaskChecked = !_isTaskChecked;
    notifyListeners();
  }

  void resetAddTaskUI() {
    _isTaskChecked = false;
    _isNotificationEnabled = false;
    _isTaskTextNotEmpty = false;
    _selectedDate = "";
    _tasks = [];
    notifyListeners();
  }

  void toggleTaskAddButton(TextEditingController t) {
    _isTaskTextNotEmpty = t.text.isNotEmpty;
    _isNotificationEnabled = t.text.isNotEmpty;
    notifyListeners();
  }
}
