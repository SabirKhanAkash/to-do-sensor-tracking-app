import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/core/services/sqflite_db_service.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_floating_action_button.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_list_app_bar.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_list_body.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  late final DBHelper dbHelper;
  late final AppState appState = Provider.of<AppState>(context, listen: false);

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    fetchData();
  }

  Future<void> fetchData() async {
    return await appState.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightWhite,
        appBar: buildToDoListAppBar(),
        body: buildToDoListBody(context),
        floatingActionButton: buildFloatingActionButton(),
      ),
    );
  }
}
