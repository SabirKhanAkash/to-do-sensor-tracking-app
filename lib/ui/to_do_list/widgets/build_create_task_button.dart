import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Consumer<AppState> buildCreateTaskButton() {
  return Consumer<AppState>(builder: (context, data, _) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: const Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 15),
        child: ListTile(
          leading: Icon(
            Icons.add_circle,
            color: AppColors.primary,
          ),
          title: Text(
            "Add a Task",
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            style: TextStyle(color: AppColors.listTitleColor, fontSize: 14),
          ),
          titleAlignment: ListTileTitleAlignment.center,
        ),
      ),
    );
  });
}
