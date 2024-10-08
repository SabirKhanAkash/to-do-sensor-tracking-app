import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_add_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_task_entry_ui.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Consumer<AppState> buildCreateTaskButton(TextEditingController taskController) {
  return Consumer<AppState>(builder: (context, data, _) {
    return GestureDetector(
      onTap: () => data.isTaskAdding ? () : data.toggleTaskAddButtonVisibility(),
      child: data.isTaskAdding
          ? buildTaskEntryUI(context, taskController)
          : buildTaskAddButton(context),
    );
  });
}
