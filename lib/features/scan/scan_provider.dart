import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:paktext/core/services/camera_service.dart';
import 'package:paktext/core/services/ocr_service.dart';

class ScanProvider extends ChangeNotifier{
  final CameraService _cameraProvider = CameraService();
  final OcrService _ocrService = OcrService();

  File? imageFile;
  String extractedText = '';
  bool isLoading = false;

  Future<void> pickImageFromCamera()  async {
    isLoading = true;
    notifyListeners();

    imageFile = await _cameraProvider.pickImageFromCamera();
    if(imageFile != null)  await runOcr();

    isLoading = false;
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
      isLoading = true;
      notifyListeners();

      imageFile = await _cameraProvider.pickImageFromGallery();
      if(imageFile != null)  await runOcr();

      isLoading = false;
      notifyListeners();
  }

  Future<void> runOcr() async {
    if(imageFile == null) return;
    extractedText = await _ocrService.recognizeText(imageFile!);
    notifyListeners();
  }

}