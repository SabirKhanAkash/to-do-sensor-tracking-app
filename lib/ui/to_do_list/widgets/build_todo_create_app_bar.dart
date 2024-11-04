import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

PreferredSizeWidget buildToDoCreateAppBar(TextEditingController listTitleController,
    TextEditingController taskController, int dataId, Data? todo) {
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
          visible: data.taskList.isNotEmpty,
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
              onPressed: () async {
                data.resetAddTaskUI();
                if (todo == null) {
                  await data.addData(
                      Data(id: dataId, title: listTitleController.text, taskList: data.taskList));
                } else {
                  await data.loadTasksOfData(dataId);
                  await data.updateData(
                      Data(id: dataId, title: listTitleController.text, taskList: data.taskList));
                }
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
