import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildBody(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          height: 76,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: AppColors.toDoListMenuButtonColor,
              padding: const EdgeInsets.symmetric(horizontal: 10), // Padding inside the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Optional: Adds rounded corners
              ),
            ),
            onPressed: () async => (),
            child: const Text(
              "A To-Do List",
              style: TextStyle(fontSize: 21, fontFamily: 'poppins'),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          height: 76,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.sensorTrackingMenuButtonColor,
              padding: const EdgeInsets.symmetric(horizontal: 10), // Padding inside the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Optional: Adds rounded corners
              ),
            ),
            onPressed: () async => (),
            child: const Text(
              "Sensor Tracking",
              style: TextStyle(fontSize: 21, fontFamily: 'poppins'),
            ),
          ),
        )
      ],
    ),
  );
}
