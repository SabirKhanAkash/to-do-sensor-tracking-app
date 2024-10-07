import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoListBody(BuildContext context) {
  return Consumer<AppState>(builder: (context, data, _) {
    return ListView.builder(
      itemCount: data.toDoList.length,
      padding: const EdgeInsets.only(top: 15),
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListTile(
          leading: Icon(
            Icons.format_list_bulleted_rounded,
            color: AppColors.primary,
          ),
          title: Text(
            "${jsonEncode(data.toDoList.length)}",
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            style: TextStyle(color: AppColors.listTitleColor, fontSize: 14),
          ),
          titleAlignment: ListTileTitleAlignment.center,
          trailing: Text(
            "1",
            style: TextStyle(fontSize: 15, color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  });
}
