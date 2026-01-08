import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  static Future<bool> isCameraGranted() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> isGalleryGranted() async {
    final status = await Permission.photos.request();
    return status.isGranted || await Permission.storage.request().isGranted;
  }
}
