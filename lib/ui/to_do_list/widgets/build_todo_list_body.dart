import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoListBody(
  BuildContext context,
  List<Data>? allData,
) {
  return Stack(
    children: [
      const Divider(
        color: AppColors.grayLineColor,
        height: 0.5,
      ),
      ListView.builder(
        itemCount: allData?.length ?? 0,
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
              "${allData?[index].title}",
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
      ),
    ],
  );
}
