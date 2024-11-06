import 'package:permission_handler/permission_handler.dart';

class PermissionRequest {
  Future<void> promptForNotification() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    } else if (await Permission.notification.isPermanentlyDenied) {
      await Permission.notification.request();
      await openAppSettings();
    }
  }
}
