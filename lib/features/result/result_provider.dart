import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paktext/features/home/HomeProvider.dart';
import 'package:provider/provider.dart';
import '../../core/services/storage_service.dart';

class ResultProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  String? text;

  void setText(String t) {
    text = t;
    notifyListeners();
  }

  Future<void> saveText(BuildContext context) async {
    if (text == null || text!.isEmpty) return;

    // Save OCR text
    await _storageService.saveScan(text!);

    // Increment scan count on HomeProvider
    final homeProvider = Provider.of<Homeprovider>(context, listen: false);
    homeProvider.increment();
  }

  void copyToClipboard() {
    if (text != null && text!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text!));
    }
  }
}
