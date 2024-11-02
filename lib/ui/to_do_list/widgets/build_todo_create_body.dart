import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/core/services/log_service.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoCreateBody(
    BuildContext context, TextEditingController listTitleController, int dataId) {
  return Consumer<AppState>(builder: (context, data, _) {
    Log.create(Level.info, "tasks: ${jsonEncode(data.taskList)}");
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
            itemBuilder: (context, index) => Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ListTile(
                leading: Checkbox(
                  fillColor: MaterialStateProperty.all(Colors.white),
                  activeColor: (AppColors.primary),
                  checkColor: Colors.white,
                  value: false,
                  onChanged: (bool? value) {
                    value = !value!;
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
                trailing: const Icon(
                  Icons.star_border_rounded,
                  color: AppColors.darkGray,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  });
}
