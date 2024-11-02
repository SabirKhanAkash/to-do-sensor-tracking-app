import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

Widget buildTaskAddButton(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 32,
    child: Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: SvgPicture.string(fit: BoxFit.cover, AppImages().addTaskIcon),
        title: const Text(
          "Add a Task",
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: TextStyle(color: AppColors.listTitleColor, fontSize: 14),
        ),
        titleAlignment: ListTileTitleAlignment.center,
      ),
    ),
  );
}
