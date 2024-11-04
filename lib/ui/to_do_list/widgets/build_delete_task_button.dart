import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_delete_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_delete_ui.dart';

GestureDetector buildDeleteTaskButton(BuildContext context, Task task) {
  return GestureDetector(
    onTap: () => buildTaskDeleteUI(context, task),
    child: buildTaskDeleteButton(context),
  );
}
