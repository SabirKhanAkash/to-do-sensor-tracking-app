import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoCreateBody(BuildContext context, TextEditingController listTitleController) {
  return Consumer<AppState>(builder: (context, data, _) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Untitled List (0)',
              filled: false,
              border: InputBorder.none,
              hintStyle: TextStyle(color: AppColors.midGray),
            ),
            maxLines: 1,
            style: TextStyle(color: AppColors.listTitleColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.taskList.length,
            // itemCount: 3,
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
                    value = true;
                  },
                ),
                title: Text(
                  "${jsonEncode(data.taskList.length)}",
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                      color: AppColors.listTitleColor, fontSize: 14, fontFamily: 'inter'),
                ),
                subtitle: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.midGray,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Fri, 14 Sep",
                      style: TextStyle(color: AppColors.midGray, fontSize: 10),
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
