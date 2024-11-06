import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/to_do_create_screen.dart';
import 'package:to_do_sensor_tracking_app/ui/to_do_list/widgets/build_todo_delete_ui.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildToDoListBody(
  BuildContext context,
) {
  return Consumer<AppState>(builder: (context, data, _) {
    return RefreshIndicator(
      color: AppColors.lightWhite,
      backgroundColor: AppColors.primary,
      onRefresh: data.loadData,
      child: Stack(
        children: [
          const Divider(
            color: AppColors.grayLineColor,
            height: 0.5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.dataList.length,
              padding: const EdgeInsets.only(top: 15),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => buildToDoDeleteUI(context, data.dataList[index]),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ToDoCreateScreen(
                              data: data.dataList[index],
                              dataId: data.dataList[index].id ?? (index + 1),
                            )),
                  ),
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ListTile(
                      leading: const Icon(
                        Icons.format_list_bulleted_rounded,
                        color: AppColors.primary,
                      ),
                      title: Text(
                        data.dataList[index].title ?? 'No title',
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(color: AppColors.listTitleColor, fontSize: 14),
                      ),
                      titleAlignment: ListTileTitleAlignment.center,
                      trailing: Text(
                        "${data.dataList[index].taskList?.length ?? 0}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  });
}
