import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class OcrService {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<String> recognizeText(File imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    return recognizedText.text;
  }

  void dispose() {
    textRecognizer.close();
  }

}