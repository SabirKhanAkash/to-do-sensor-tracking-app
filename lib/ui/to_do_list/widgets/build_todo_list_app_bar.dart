import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_sensor_tracking_app/core/services/db_manager.dart';
import 'package:to_do_sensor_tracking_app/data/models/data_model/data.dart';

PreferredSizeWidget buildToDoListAppBar(DbManager dbManager) {
  return AppBar(
    forceMaterialTransparency: true,
    titleSpacing: 5,
    backgroundColor: Colors.transparent,
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: ClipOval(
          child: Image.asset(
            "assets/images/myself.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    title: const Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sabir Khan Akash",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          "5 incomplete, 5 completed",
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 14, letterSpacing: 0.1),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SvgPicture.string(
          '''<svg width="5" height="5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3
          .org/2000/svg">
<path d="M11 19C15.4183 19 19 15.4183 19 11C19 6.58172 15.4183 3 11 3C6.58172 3 3 6.58172 3 11C3 15.4183 6.58172 19 11 19Z" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M21 21L16.65 16.65" stroke="black" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''',
          fit: BoxFit.cover,
        ),
      )
    ],
  );
}
