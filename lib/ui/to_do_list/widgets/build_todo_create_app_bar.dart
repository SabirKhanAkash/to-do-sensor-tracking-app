import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

PreferredSizeWidget buildToDoCreateAppBar(
  BuildContext context,
  TextEditingController listTitleController,
  TextEditingController taskController,
) {
  return AppBar(
    forceMaterialTransparency: true,
    titleSpacing: 5,
    backgroundColor: Colors.transparent,
    leading: Consumer<AppState>(builder: (context, data, _) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            data.resetAddTaskUI();
            Navigator.pop(context);
          },
          child: SvgPicture.string(
            fit: BoxFit.cover,
            AppImages().backButton,
          ),
        ),
      );
    }),
    title: const Text(
      "Lists",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 16),
    ),
    actions: [
      Consumer<AppState>(builder: (context, data, _) {
        return Visibility(
          visible: data.isTaskChecked,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                data.resetAddTaskUI();
                List<Task> taskList = [
                  Task(
                    taskTitle: taskController.text,
                    createdDate: DateTime.now().toString(),
                    status: 'incomplete',
                  ),
                ];

                Data newData = Data(
                  title: listTitleController.text,
                  taskList: taskList,
                );

                data.addData(newData);

                listTitleController.clear();
                taskController.clear();

                Navigator.pop(context);
              },
              child: const Text(
                "Done",
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'poppins'),
              ),
            ),
          ),
        );
      })
    ],
  );
}
