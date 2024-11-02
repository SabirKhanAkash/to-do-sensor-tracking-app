import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

PreferredSizeWidget buildToDoListAppBar(DBHelper dbHelper) {
  return AppBar(
    toolbarHeight: 75,
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/myself.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    title: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sabir Khan Akash",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          "5 incomplete, 5 completed",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () {
            // Add your search function here
          },
          icon: SvgPicture.string(
            AppImages().searchIcon,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
