import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/task_screen.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoCreateBody(TextEditingController listTitleController) {
  return Consumer<AppState>(builder: (context, data, _) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: listTitleController,
            decoration: const InputDecoration(
              hintText: 'Untitled List (0)',
              filled: false,
              border: InputBorder.none,
              hintStyle: TextStyle(color: AppColors.midGray),
            ),
            maxLines: 1,
            style: const TextStyle(color: AppColors.listTitleColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.taskList.length,
            reverse: false,
            padding: const EdgeInsets.only(top: 5),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskScreen(
                          task: data.taskList[index],
                        )),
              ),
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: ListTile(
                  leading: Checkbox(
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return Colors.white;
                    }),
                    checkColor: Colors.white,
                    side: WidgetStateBorderSide.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return const BorderSide(color: AppColors.primary);
                      }
                      return const BorderSide(color: Colors.grey);
                    }),
                    value: data.taskList[index].status == "completed",
                    onChanged: (bool? value) {
                      value = data.toggleSpecificTask(index, value!);
                    },
                  ),
                  title: Text(
                    "${data.taskList[index].taskTitle}",
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        color: AppColors.listTitleColor, fontSize: 14, fontFamily: 'inter'),
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: AppColors.midGray,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${data.taskList[index].createdDate}",
                        style: const TextStyle(color: AppColors.midGray, fontSize: 10),
                      )
                    ],
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  trailing: GestureDetector(
                    onTap: () => data.toggleNotificationOfSpecificTask(index),
                    child: data.taskList[index].notificationEnabled == 1
                        ? const Icon(
                            Icons.star,
                            color: AppColors.primary,
                          )
                        : const Icon(
                            Icons.star_border_rounded,
                            color: AppColors.darkGray,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  });
}
