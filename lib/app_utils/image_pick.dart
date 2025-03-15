import 'dart:io';

import 'package:bloc_structure/app_utils/common_util_methods.dart';
import 'package:bloc_structure/app_utils/permission_handling_service.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {

  static Future<String?> imagePick({
    required bool isMultiple,
  }) async {
    if(Platform.isIOS) {
      await PermissionHandlingService().handlePhotosPermission().then((
          value) async {
        if (value == true) {
          pickImage(isMultiple: isMultiple);
        } else if (value == true) {
          CommonUtilMethods.showSnackBar(
              message: "Gallery permission denied.");
          PermissionHandlingService().requestPhotosPermission();
          //  PermissionHandlingService().openAppSettings();
        }
      },);
    }else{
      pickImage(isMultiple: isMultiple);
    }
    return null ;
  }

  static Future<String?> pickImage({
    required bool isMultiple,
  }) async {

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }

    return null;
  }
}