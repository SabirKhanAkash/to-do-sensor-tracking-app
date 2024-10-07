import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoCreateBody(BuildContext context) {
  return Consumer<AppState>(builder: (context, data, _) {
    return ListView.builder(
      // itemCount: data.taskList.length,
      itemCount: 3,
      padding: const EdgeInsets.only(top: 15),
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
            style: TextStyle(color: AppColors.listTitleColor, fontSize: 14, fontFamily: 'inter'),
          ),
          subtitle: Row(
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
          trailing: Icon(
            Icons.star_border_rounded,
            color: AppColors.darkGray,
          ),
        ),
      ),
    );
  });
}
