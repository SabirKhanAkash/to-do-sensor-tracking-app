import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

Widget buildTaskDetailsBody(Task task) {
  return Consumer<AppState>(builder: (context, data, _) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40, bottom: 10),
          child: Row(
            children: [
              SvgPicture.string(
                AppImages().bellIcon,
                color: task.notificationEnabled == 1 ? AppColors.primary : AppColors.lightGray,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Remind Me",
                style: TextStyle(
                    color: task.notificationEnabled == 1 ? AppColors.primary : AppColors.lightGray,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: [
              SvgPicture.string(
                AppImages().calenderIcon,
                color: AppColors.primary,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Due ${task.createdDate}",
                style: TextStyle(color: AppColors.primary, fontSize: 16),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: [
              SvgPicture.string(
                AppImages().copyIcon,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Add Note",
                style: TextStyle(color: AppColors.lightGray, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  });
}
