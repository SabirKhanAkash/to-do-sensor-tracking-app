import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_sensor_tracking_app/core/services/shared_pref_service.dart';
import 'package:to_do_sensor_tracking_app/core/services/sqflite_db_service.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

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

  Future<void> getCompletedIncompleted() async {
    _completed = await SharedPreference().getInt("completedDataCount") ?? 0;
    _incompleted = await SharedPreference().getInt("incompleteDataCount") ?? 0;
    notifyListeners();
  }

  void resetAddTaskUI() {
    _isTaskChecked = false;
    _isNotificationEnabled = false;
    _isTaskTextNotEmpty = false;
    _selectedDate = "";
    notifyListeners();
  }

  void setDate(String formattedPickedDate) {
    _selectedDate = formattedPickedDate;
    notifyListeners();
  }

  void toggleNotification() {
    _isNotificationEnabled = !_isNotificationEnabled;
    notifyListeners();
  }

  void toggleNotificationOfSpecificTask(int index) {
    _taskList[index].notificationEnabled = _taskList[index].notificationEnabled == 1 ? 0 : 1;
    _taskList[index].notificationEnabled == 1
        ? Fluttertoast.showToast(
            msg: "Notification enabled for this task",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primary,
            textColor: Colors.white,
          )
        : Fluttertoast.showToast(
            msg: "Notification disabled for this task",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
          );
    notifyListeners();
  }

  bool toggleSpecificTask(int index, bool value) {
    _taskList[index].status = !value ? "incomplete" : "completed";
    notifyListeners();
    return !value;
  }

  void toggleTaskAddButton(TextEditingController t) {
    _isTaskTextNotEmpty = t.text.isNotEmpty;
    _isNotificationEnabled = t.text.isNotEmpty;
    notifyListeners();
  }

  void toggleTaskAddCheckBoxVisibility() {
    _isTaskChecked = !_isTaskChecked;
    notifyListeners();
  }

  Future<void> addData(Data data) async {
    await DBHelper().insertData(data);
    await loadData();
  }

  Future<void> loadData() async {
    _dataList = await DBHelper().getAllData();
    await getCompletedIncompleted();
    notifyListeners();
  }

  Future<void> updateData(Data data) async {
    await DBHelper().updateData(data);
    await loadData();
    notifyListeners();
  }

  Future<void> deleteData(int dataId) async {
    await DBHelper().deleteData(dataId);
    await loadData();
    notifyListeners();
  }

  void addTask(Task newTask) {
    _taskList.add(newTask);
    notifyListeners();
  }

  Future<void> loadTasksOfData(int dataId) async {
    _taskList = await DBHelper().getTasksOfData(dataId);
    notifyListeners();
  }

  Future<void> deleteTask(int taskId, int dataId) async {
    await DBHelper().deleteTask(taskId);
    await loadTasksOfData(dataId);
    await DBHelper().deleteDataIfNoTasks(dataId);
    await loadData();
    notifyListeners();
  }
}
