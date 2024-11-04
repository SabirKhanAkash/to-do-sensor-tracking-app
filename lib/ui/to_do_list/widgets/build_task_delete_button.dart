import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

Widget buildTaskDeleteButton(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 32,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        leading: SvgPicture.string(fit: BoxFit.cover, AppImages().deleteIcon),
        title: const Text(
          "Delete",
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: TextStyle(color: AppColors.lightGray, fontSize: 14),
        ),
        titleAlignment: ListTileTitleAlignment.center,
      ),
    ),
  );
}
