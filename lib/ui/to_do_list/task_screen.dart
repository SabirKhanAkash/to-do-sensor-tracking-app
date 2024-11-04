import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_delete_task_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_details_app_bar.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_details_body.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

class TaskScreen extends StatefulWidget {
  final Task task;

  const TaskScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final AppState appState = Provider.of<AppState>(context, listen: false);
  final TextEditingController listTitleController = TextEditingController();
  final TextEditingController taskController = TextEditingController();

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: AppColors.lightWhite,
          appBar: buildTaskDetailsAppBar(widget.task),
          body: buildTaskDetailsBody(widget.task),
          floatingActionButton: buildDeleteTaskButton(context, widget.task),
        ),
      ),
    );
  }
}
