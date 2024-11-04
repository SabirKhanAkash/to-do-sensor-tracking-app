import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_image.dart';

PreferredSizeWidget buildToDoListAppBar() {
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
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sabir Khan Akash",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Consumer<AppState>(builder: (context, data, _) {
          data.setCompletedIncompleted();
          return Text(
            "${data.incompleted} incomplete, ${data.completed} completed",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          );
        }),
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
