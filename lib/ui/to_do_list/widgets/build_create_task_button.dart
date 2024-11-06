import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_add_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_entry_ui.dart';

GestureDetector buildCreateTaskButton(BuildContext context, TextEditingController taskController, int dataId) {
  return GestureDetector(
    onTap: () => buildTaskEntryUI(context, taskController, dataId),
    child: buildTaskAddButton(context),
  );
}
