import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSizeWidget buildToDoListAppBar() {
  return AppBar(
    forceMaterialTransparency: true,
    leadingWidth: 80,
    titleSpacing: 5,
    backgroundColor: Colors.transparent,
    leading: Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: ClipOval(
        child: SvgPicture.asset(
          "assets/images/user_avatar.svg",
          fit: BoxFit.cover,
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
    actions: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.search,
          size: 40,
        ),
      )
    ],
  );
}
