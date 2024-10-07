import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

class AppState extends ChangeNotifier {
  List<Data> _toDoList = [];
  List<Task> _taskList = [];

  List<Data> get toDoList => _toDoList;

  List<Task> get taskList => _taskList;

  void addToDoItem(Data item) {
    _toDoList.add(item);
    notifyListeners();
  }

  void addTaskItem(Task item) {
    _taskList.add(item);
    notifyListeners();
  }
}
