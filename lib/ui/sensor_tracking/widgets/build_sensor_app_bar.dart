import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

PreferredSizeWidget buildSensorAppBar(BuildContext context) {
  return AppBar(
    centerTitle: false,
    titleSpacing: 5,
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.string(
          fit: BoxFit.cover,
          AppImages().backButton,
        ),
      ),
    ),
    title: const Text(
      "Sensor Tracking",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 16),
    ),
  );
}
