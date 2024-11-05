import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

void buildTaskDeleteUI(BuildContext parentContext, Task task) {
  showModalBottomSheet(
    enableDrag: true,
    context: parentContext,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
    ),
    backgroundColor: Colors.transparent,
    builder: (BuildContext ctx) {
      return Consumer<AppState>(builder: (_, data, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 100),
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              width: MediaQuery.of(ctx).size.width - 30,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5.0, bottom: 10),
                      child: Text(
                        "\“${task.taskTitle}\” will be permanently deleted.",
                        style: const TextStyle(color: AppColors.lightGray, fontSize: 14),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: AppColors.lightWhite,
                    ),
                    GestureDetector(
                      onTap: () {
                        data.deleteTask(task.id ?? 0, task.dataId ?? 0);
                        Navigator.pop(ctx);
                        Navigator.pop(ctx);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20, top: 10.0, bottom: 10),
                        child: Text(
                          "Delete Task",
                          style: TextStyle(color: AppColors.red, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(ctx),
              child: AnimatedContainer(
                alignment: Alignment.center,
                curve: Curves.linear,
                duration: const Duration(milliseconds: 100),
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                width: MediaQuery.of(ctx).size.width - 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20, top: 10.0, bottom: 10),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: AppColors.primary, fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      });
    },
  );
}
