import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

PreferredSizeWidget buildToDoCreateAppBar(BuildContext context,
    TextEditingController listTitleController, TextEditingController taskController) {
  return AppBar(
    forceMaterialTransparency: true,
    titleSpacing: 5,
    backgroundColor: Colors.transparent,
    leading: Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.string(
              fit: BoxFit.cover,
              '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M10 6L4 12M4 12L10 18M4 12H19" stroke="#111111" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''')),
    ),
    title: const Text(
      "Lists",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 16),
    ),
    actions: [
      Consumer<AppState>(builder: (context, data, _) {
        return Visibility(
          visible: data.isTaskAdding,
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
              onPressed: () => data.addTaskItem(
                  Task(taskTitle: "Task A", createdDate: "Tue, 08 Oct", status: "incomplete"),
                  listTitleController.text),
              child: const Text(
                "Done",
                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'poppins'),
              ),
            ),
          ),
        );
      })
    ],
  );
}
