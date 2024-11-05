import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_create_task_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_create_app_bar.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_create_body.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

class ToDoCreateScreen extends StatefulWidget {
  final int dataId;
  final Data? data;

  const ToDoCreateScreen({
    Key? key,
    this.data,
    required this.dataId,
  }) : super(key: key);

  @override
  State<ToDoCreateScreen> createState() => _ToDoCreateScreenState();
}

class _ToDoCreateScreenState extends State<ToDoCreateScreen> {
  late final AppState appState = Provider.of<AppState>(context, listen: false);
  final TextEditingController listTitleController = TextEditingController();
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listTitleController.text = widget.data?.title ?? "Untitled List (${widget.dataId})";
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    return await appState.loadTasksOfData(widget.dataId);
  }

  Future<bool> _onWillPop() async {
    appState.resetAddTaskUI();
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.lightWhite,
        appBar: buildToDoCreateAppBar(
            listTitleController, taskController, widget.dataId, widget.data),
        body: buildToDoCreateBody(listTitleController),
        floatingActionButton: buildCreateTaskButton(context, taskController, widget.dataId),
      ),
    );
  }
}
