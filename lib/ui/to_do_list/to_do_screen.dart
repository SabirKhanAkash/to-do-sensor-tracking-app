import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_floating_action_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_list_app_bar.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_list_body.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightWhite,
      extendBodyBehindAppBar: false,
      appBar: buildToDoListAppBar(),
      body: buildToDoListBody(context),
      floatingActionButton: buildFloatingActionButton(),
    );
  }
}