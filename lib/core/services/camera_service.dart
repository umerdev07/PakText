import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromCamera() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }

  Future<File?> pickImageFromGallery() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }
}
