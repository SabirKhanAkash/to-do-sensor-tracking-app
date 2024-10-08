import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildTaskAddButton(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 32,
    child: Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        leading: SvgPicture.string(
            fit: BoxFit.cover,
            '''<svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
<g filter="url(#filter0_d_29_311)">
<circle cx="20" cy="18" r="12" fill="url(#paint0_linear_29_311)"/>
<circle cx="20" cy="18" r="11" stroke="#33CCCC" stroke-width="2"/>
</g>
<path d="M19.9999 13.7143V22.2857M15.7142 18H24.2857" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="bevel"/>
<defs>
<filter id="filter0_d_29_311" x="0" y="0" width="40" height="40" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
<feOffset dy="2"/>
<feGaussianBlur stdDeviation="4"/>
<feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.25 0"/>
<feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_29_311"/>
<feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_29_311" result="shape"/>
</filter>
<linearGradient id="paint0_linear_29_311" x1="20" y1="6" x2="20" y2="30" gradientUnits="userSpaceOnUse">
<stop stop-color="#33CCCC"/>
<stop offset="1" stop-color="#19BEBE"/>
</linearGradient>
</defs>
</svg>
'''),
        title: const Text(
          "Add a Task",
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: TextStyle(color: AppColors.listTitleColor, fontSize: 14),
        ),
        titleAlignment: ListTileTitleAlignment.center,
      ),
    ),
  );
}
