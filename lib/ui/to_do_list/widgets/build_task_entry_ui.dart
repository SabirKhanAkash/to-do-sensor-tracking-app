import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/date_picker.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';
import 'package:to_do_sensor_tracking_app/utils/format_date.dart';

void buildTaskEntryUI(
    BuildContext parentContext, TextEditingController taskController, int dataId) {
  showModalBottomSheet(
    enableDrag: true,
    context: parentContext,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext ctx) {
      return Consumer<AppState>(builder: (_, data, __) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: AnimatedContainer(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            width: MediaQuery.of(ctx).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Checkbox(
                      value: data.isTaskChecked || data.isTaskTextNotEmpty,
                      onChanged: (bool? value) {
                        data.toggleTaskAddCheckBoxVisibility();
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return AppColors.primary;
                        }
                        return Colors.white;
                      }),
                      checkColor: Colors.white,
                      side: MaterialStateBorderSide.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return const BorderSide(color: AppColors.primary);
                        }
                        return const BorderSide(color: Colors.grey);
                      }),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextField(
                          onChanged: (text) {
                            data.toggleTaskAddButton(taskController);
                          },
                          controller: taskController,
                          decoration: const InputDecoration(
                            hintText: 'Add a task',
                            filled: false,
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.midGray),
                          ),
                          maxLines: 1,
                          style: const TextStyle(color: AppColors.listTitleColor),
                        ),
                      ),
                    ),
                    data.isTaskTextNotEmpty
                        ? GestureDetector(
                            onTap: () async {
                              Task newTask = Task(
                                id: data.taskList.length + 1,
                                dataId: dataId,
                                notificationEnabled: data.isNotificationEnabled ? 1 : 0,
                                taskTitle: taskController.text,
                                createdDate: data.selectedDate != ""
                                    ? data.selectedDate.toString()
                                    : formatDate(DateTime.now()),
                                status: 'incomplete',
                              );
                              data.addTask(newTask);
                              taskController.clear();
                              data.resetAddTaskUI();
                              Navigator.pop(ctx);
                            },
                            child: SvgPicture.string(AppImages().tickIcon),
                          )
                        : SvgPicture.string(AppImages().untickIcon)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => data.toggleNotification(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: data.isNotificationEnabled
                            ? SvgPicture.string(
                                AppImages().bellIcon,
                                color: AppColors.primary,
                              )
                            : SvgPicture.string(AppImages().bellIcon),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data.isTaskTextNotEmpty) {
                          Clipboard.setData(ClipboardData(text: taskController.text));
                          Fluttertoast.showToast(
                            msg: "Task copied to clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: AppColors.primary,
                            textColor: Colors.white,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.string(AppImages().copyIcon),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await selectDate(ctx, data);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: data.selectedDate == ""
                            ? SvgPicture.string(AppImages().calenderIcon)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.string(
                                    AppImages().calenderIcon,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    data.selectedDate,
                                    style: const TextStyle(color: AppColors.primary),
                                  ),
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
