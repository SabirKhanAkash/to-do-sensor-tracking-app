import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/ui/sensor_tracking/sensor_tracking_screen.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/to_do_screen.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () async => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ToDoScreen()),
            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () async => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SensorTrackingScreen()),
            ),
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
