import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/to_do_create_screen.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Consumer<AppState> buildFloatingActionButton(DbManager dbManager) {
  return Consumer<AppState>(builder: (context, data, _) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      shape: const CircleBorder(side: BorderSide.none),
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ToDoCreateScreen(dbManager)),
      ),
    );
  });
}
