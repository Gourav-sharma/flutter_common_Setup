import 'package:permission_handler/permission_handler.dart';

class PermissionHandling {


  static Future<PermissionStatus> requestPermission(Permission permission) async {
    final status = await permission.request();
    switch (status) {
      case PermissionStatus.granted:
        return status;
      case PermissionStatus.denied:
        return status;
      case PermissionStatus.permanentlyDenied:
        return status;
      default:
        return status;
    }
  }

  static Future<PermissionStatus> checkPermission(Permission permission) async {

    final PermissionStatus status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
        return status;
      case PermissionStatus.denied:
        return status;
      case PermissionStatus.permanentlyDenied:

        return status;
      default:
        return status;
    }
  }

  static Future<void> openAppSetting() async {
    await openAppSettings();

  }



}