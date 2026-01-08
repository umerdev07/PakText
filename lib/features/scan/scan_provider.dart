import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/services/camera_service.dart';
import '../../core/services/ocr_service.dart';
import '../../core/utils/permission_utils.dart';

class ScanProvider extends ChangeNotifier {
  final CameraService _cameraService = CameraService();
  final OcrService _ocrService = OcrService();

  File? imageFile;
  String extractedText = '';
  bool isLoading = false;

  Future<void> pickImageFromCamera(BuildContext context) async {
    final granted = await PermissionUtils.isCameraGranted();

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied')),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    imageFile = await _cameraService.pickImageFromCamera();

    if (imageFile != null) {
      extractedText = await _ocrService.recognizeText(imageFile!);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final granted = await PermissionUtils.isGalleryGranted();

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery permission denied')),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    imageFile = await _cameraService.pickImageFromGallery();

    if (imageFile != null) {
      extractedText = await _ocrService.recognizeText(imageFile!);
    }

    isLoading = false;
    notifyListeners();
  }
}
