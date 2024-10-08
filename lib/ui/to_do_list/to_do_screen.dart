import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';
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
  late final DbManager dbManager;
  List<Data>? allData;

  @override
  void initState() {
    super.initState();
    dbManager = DbManager();
    loadData();
  }

  Future<void> loadData() async {
    allData = await dbManager.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightWhite,
        appBar: buildToDoListAppBar(dbManager),
        body: buildToDoListBody(context, allData),
        floatingActionButton: buildFloatingActionButton(dbManager),
      ),
    );
  }
}
