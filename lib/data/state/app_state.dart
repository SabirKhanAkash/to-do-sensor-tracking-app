import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/core/services/shared_pref_service.dart';
import 'package:to_do_sensor_tracking_app/core/services/sqflite_db_service.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

class AppState extends ChangeNotifier {
  bool _isTaskChecked = false;
  bool _isNotificationEnabled = false;
  bool _isTaskTextNotEmpty = false;
  String _selectedDate = "";
  List<Data> _dataList = [];
  List<Task> _taskList = [];
  int _completed = 0;
  int _incompleted = 0;

  int get completed => _completed;

  int get incompleted => _incompleted;

  List<Data> get dataList => _dataList;

  List<Task> get taskList => _taskList;

  String get selectedDate => _selectedDate;

  bool get isTaskChecked => _isTaskChecked;

  bool get isNotificationEnabled => _isNotificationEnabled;

  bool get isTaskTextNotEmpty => _isTaskTextNotEmpty;

  Future<void> setCompletedIncompleted() async {
    _completed = await SharedPreference().getInt("completedDataCount") ?? 0;
    _incompleted = await SharedPreference().getInt("incompleteDataCount") ?? 0;
    notifyListeners();
  }

  bool toggleSpecificTask(int index, bool value) {
    _taskList[index].status = !value ? "incomplete" : "completed";
    notifyListeners();
    return !value;
  }

  void setDate(String formattedPickedDate) {
    _selectedDate = formattedPickedDate;
    notifyListeners();
  }

  Future<void> loadData() async {
    _dataList = await DBHelper().getAllData();
    await setCompletedIncompleted();
    notifyListeners();
  }

  Future<void> loadTasksOfData(int dataId) async {
    _taskList = await DBHelper().getTasksOfData(dataId);
    notifyListeners();
  }

  Future<void> addData(Data data) async {
    await DBHelper().insertData(data);
    await loadData();
  }

  Future<void> updateData(Data data) async {
    await DBHelper().updateData(data);
    await loadTasksOfData(data.id ?? 0);
    await loadData();
    notifyListeners();
  }

  /// TBD
  Future<void> updateTask(Task task) async {
    await DBHelper().updateTask(task);
    await loadData();
    notifyListeners();
  }

  Future<void> deleteTask(int taskId, int dataId) async {
    await DBHelper().deleteTask(taskId);
    await loadTasksOfData(dataId);
    await DBHelper().deleteDataIfNoTasks(dataId);
    await loadData();
    notifyListeners();
  }

  Future<void> deleteData(int dataId) async {
    await DBHelper().deleteData(dataId);
    await loadData();
    notifyListeners();
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
    notifyListeners();
  }

  void toggleTaskAddButton(TextEditingController t) {
    _isTaskTextNotEmpty = t.text.isNotEmpty;
    _isNotificationEnabled = t.text.isNotEmpty;
    notifyListeners();
  }
}
