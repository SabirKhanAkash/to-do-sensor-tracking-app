import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

PreferredSizeWidget buildToDoCreateAppBar(BuildContext context) {
  return AppBar(
    forceMaterialTransparency: true,
    leadingWidth: 65,
    titleSpacing: 5,
    backgroundColor: Colors.transparent,
    leading:
        GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back)),
    title: const Text(
      "Lists",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 16),
    ),
    actions: [
      Visibility(
        visible: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), // Padding inside
              // the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Optional: Adds rounded corners
              ),
            ),
            onPressed: () async => (),
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'poppins'),
            ),
          ),
        ),
      )
    ],
  );
}
