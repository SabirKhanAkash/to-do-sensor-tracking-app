import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_create_task_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_create_app_bar.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_create_body.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

class ToDoCreateScreen extends StatefulWidget {
  const ToDoCreateScreen({super.key});

  @override
  State<ToDoCreateScreen> createState() => _ToDoCreateScreenState();
}

class _ToDoCreateScreenState extends State<ToDoCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhite,
      appBar: buildToDoCreateAppBar(context),
      body: buildToDoCreateBody(context),
      floatingActionButton: buildCreateTaskButton(),
    );
  }
}
