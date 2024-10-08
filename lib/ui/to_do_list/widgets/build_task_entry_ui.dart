import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_sensor_tracking_app/data/state/app_state.dart';
import 'package:to_do_sensor_tracking_app/utils/config/app_colors.dart';

Widget buildTaskEntryUI(BuildContext context, TextEditingController taskController) {
  return Consumer<AppState>(builder: (context, data, _) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.white),
        width: MediaQuery.sizeOf(context).width - 32,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    // Toggle logic here
                  },
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppColors.primary;
                    }
                    return Colors.white;
                  }),
                  checkColor: Colors.white,
                  side: MaterialStateBorderSide.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return BorderSide(color: AppColors.primary);
                    }
                    return const BorderSide(color: Colors.grey);
                  }),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextField(
                      controller: taskController,
                      decoration: InputDecoration(
                        hintText: 'Add a task',
                        filled: false,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: AppColors.midGray),
                      ),
                      maxLines: 1,
                      style: TextStyle(color: AppColors.listTitleColor),
                    ),
                  ),
                ),
                taskController.text.isNotEmpty
                    ? SvgPicture.string(
                        '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 2C10.0222 2 8.08879 2.58649 6.4443 3.6853C4.79981 4.78412 3.51809 6.3459 2.76121 8.17317C2.00433 10.0004 1.8063 12.0111 2.19215 13.9509C2.578 15.8907 3.53041 17.6725 4.92894 19.0711C6.32746 20.4696 8.10929 21.422 10.0491 21.8079C11.9889 22.1937 13.9996 21.9957 15.8268 21.2388C17.6541 20.4819 19.2159 19.2002 20.3147 17.5557C21.4135 15.9112 22 13.9778 22 12C22 10.6868 21.7413 9.38642 21.2388 8.17317C20.7363 6.95991 19.9997 5.85752 19.0711 4.92893C18.1425 4.00035 17.0401 3.26375 15.8268 2.7612C14.6136 2.25866 13.3132 2 12 2ZM16.71 9.71L11.71 14.71C11.617 14.8037 11.5064 14.8781 11.3846 14.9289C11.2627 14.9797 11.132 15.0058 11 15.0058C10.868 15.0058 10.7373 14.9797 10.6154 14.9289C10.4936 14.8781 10.383 14.8037 10.29 14.71L8.29 12.71C8.1017 12.5217 7.99591 12.2663 7.99591 12C7.99591 11.7337 8.1017 11.4783 8.29 11.29C8.47831 11.1017 8.7337 10.9959 9 10.9959C9.26631 10.9959 9.5217 11.1017 9.71 11.29L11 12.59L15.29 8.29C15.4783 8.1017 15.7337 7.99591 16 7.99591C16.2663 7.99591 16.5217 8.1017 16.71 8.29C16.8983 8.4783 17.0041 8.7337 17.0041 9C17.0041 9.2663 16.8983 9.5217 16.71 9.71Z" fill="#33CCCC"/>
</svg>''')
                    : SvgPicture.string(
                        '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 2C10.0222 2 8.08879 2.58649 6.4443 3.6853C4.79981 4.78412 3.51809 6.3459 2.76121 8.17317C2.00433 10.0004 1.8063 12.0111 2.19215 13.9509C2.578 15.8907 3.53041 17.6725 4.92894 19.0711C6.32746 20.4696 8.10929 21.422 10.0491 21.8079C11.9889 22.1937 13.9996 21.9957 15.8268 21.2388C17.6541 20.4819 19.2159 19.2002 20.3147 17.5557C21.4135 15.9112 22 13.9778 22 12C22 10.6868 21.7413 9.38642 21.2388 8.17317C20.7363 6.95991 19.9997 5.85752 19.0711 4.92893C18.1425 4.00035 17.0401 3.26375 15.8268 2.7612C14.6136 2.25866 13.3132 2 12 2ZM16.71 9.71L11.71 14.71C11.617 14.8037 11.5064 14.8781 11.3846 14.9289C11.2627 14.9797 11.132 15.0058 11 15.0058C10.868 15.0058 10.7373 14.9797 10.6154 14.9289C10.4936 14.8781 10.383 14.8037 10.29 14.71L8.29 12.71C8.1017 12.5217 7.99591 12.2663 7.99591 12C7.99591 11.7337 8.1017 11.4783 8.29 11.29C8.47831 11.1017 8.7337 10.9959 9 10.9959C9.26631 10.9959 9.5217 11.1017 9.71 11.29L11 12.59L15.29 8.29C15.4783 8.1017 15.7337 7.99591 16 7.99591C16.2663 7.99591 16.5217 8.1017 16.71 8.29C16.8983 8.4783 17.0041 8.7337 17.0041 9C17.0041 9.2663 16.8983 9.5217 16.71 9.71Z" fill="#CFCFCF"/>
</svg>''')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.string(
                      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M13.8183 19.9364H10.1819V21.7546H13.8183V19.9364Z" fill="#A7A7A7"/>
<path d="M18.5455 17.0273V11.2091C18.5455 7.90328 16.0927 5.17745 12.9091 4.73418V2.84545H11.0909V4.73418C7.90728 5.17745 5.45455 7.90328 5.45455 11.2091V17.0273H4V18.8455H20V17.0273H18.5455ZM16.7273 17.0273H7.27273V11.2091C7.27273 8.60255 9.39346 6.48182 12 6.48182C14.6066 6.48182 16.7273 8.60255 16.7273 11.2091V17.0273Z" fill="#A7A7A7"/>
</svg>'''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.string(
                      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M17.7143 4H6.28607C5.02357 4 4.0003 5.02321 4.00023 6.28571L4 17.6821C3.99993 18.975 5.02321 20 6.28571 20H14.575C15.4843 20 16.3564 19.6386 16.9996 18.9957L18.9954 16.9996C19.6393 16.325 20 15.4857 20 14.575V6.28571C20 5.02857 18.9714 4 17.7143 4ZM5.88179 18.1179C5.81929 18.0571 5.71429 17.9214 5.71429 17.7143L5.71498 6.31786C5.715 5.97071 5.97143 5.71429 6.28643 5.71429H17.7143C18.0241 5.71429 18.2857 5.976 18.2857 6.28571V13.1429H15.1429C14.0393 13.1429 13.1429 14.0393 13.1429 15.1429V18.2857H6.28571C6.07964 18.2857 5.94429 18.1821 5.88179 18.1179ZM15.7893 17.7821C15.5321 18.0393 15.2071 18.2 14.8571 18.2571V15.1429C14.8571 14.9855 14.9855 14.8571 15.1429 14.8571H18.2582C18.2005 15.2076 18.0398 15.5314 17.7836 15.7875L15.7893 17.7821Z" fill="#A7A7A7"/>
</svg>'''),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.string(
                      '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M19.5596 4.81498H17.399V2.99757H15.5985V4.81498H8.39658V2.99757H6.59609V4.81498H4.46468C3.66923 4.81498 3.02429 5.45992 3.02429 6.25537V19.562C3.02429 20.3575 3.66923 21.0024 4.46468 21.0024H19.5596C20.355 21.0024 21 20.3575 21 19.562V6.25537C21 5.45992 20.355 4.81498 19.5596 4.81498ZM19.1995 19.2019H4.79561V10.1995H19.1995V19.2019ZM19.1995 8.39903H4.79561V6.59854H19.1995V8.39903Z" fill="#A7A7A7"/>
<path d="M13.0778 12H11.2773V13.8005H13.0778V12Z" fill="#A7A7A7"/>
<path d="M16.6788 12H14.8783V13.8005H16.6788V12Z" fill="#A7A7A7"/>
<path d="M13.0778 15.601H11.2773V17.4015H13.0778V15.601Z" fill="#A7A7A7"/>
<path d="M9.47688 15.601H7.67639V17.4015H9.47688V15.601Z" fill="#A7A7A7"/>
</svg>'''),
                )
              ],
            ),
          ],
        ),
      ),
    );
  });
}
