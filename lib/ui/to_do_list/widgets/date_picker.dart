import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/format_date.dart';

Future<void> selectDate(BuildContext context, AppState appState) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 5),
  );
  String formattedPickedDate = formatDate(pickedDate!);
  if (formattedPickedDate != appState.selectedDate) {
    appState.setDate(formattedPickedDate.toString());
  }
}
