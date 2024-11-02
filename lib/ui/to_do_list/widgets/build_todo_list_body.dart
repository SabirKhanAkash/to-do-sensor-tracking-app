import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/core/services/log_service.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/to_do_create_screen.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoListBody(
  BuildContext context,
  DBHelper dbHelper,
) {
  return Consumer<AppState>(builder: (context, data, _) {
    Log.create(Level.info, "data: ${jsonEncode(data.dataList)}");
    return RefreshIndicator(
      color: AppColors.lightWhite,
      backgroundColor: AppColors.primary,
      onRefresh: data.loadData,
      child: Stack(
        children: [
          const Divider(
            color: AppColors.grayLineColor,
            height: 0.5,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: data.dataList.length,
            padding: const EdgeInsets.only(top: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToDoCreateScreen(
                            dbHelper: dbHelper,
                            dataId: index + 1,
                          )),
                ),
                child: Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: ListTile(
                    leading: const Icon(
                      Icons.format_list_bulleted_rounded,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      data.dataList[index].title ?? 'No title',
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(color: AppColors.listTitleColor, fontSize: 14),
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    trailing: Text(
                      "${data.dataList[index].taskList?.length ?? 0}",
                      // Assuming taskList is part of Data
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  });
}
