import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

class AppState extends ChangeNotifier {
  List<Data> _toDoList = [];
  List<Task> _taskList = [];
  bool _isTaskAdding = false;
  String _listTitle = "";

  List<Data> get toDoList => _toDoList;

  String get listTitle => _listTitle;

  bool get isTaskAdding => _isTaskAdding;

  List<Task> get taskList => _taskList;

  void toggleTaskAddButtonVisibility() {
    _isTaskAdding = !_isTaskAdding;
    notifyListeners();
  }

  void addToDoItem(Data item) {
    _toDoList.add(item);
    notifyListeners();
  }

  void addTaskItem(Task item, String listTitle) {
    _taskList.add(item);
    addToDoItem(Data(title: listTitle, taskList: _taskList));
    notifyListeners();
    toggleTaskAddButtonVisibility();
  }
}
