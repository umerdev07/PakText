import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:paktext/core/services/storage_service.dart';

class ResultProvide extends ChangeNotifier{
  final StorageService _storageService = StorageService();
  String? text;

  void setText (String t){
    text = t;
    notifyListeners();
  }

  Future<void> saveText() async {
    if(text != null) {
      await _storageService.saveScan(text!);
      notifyListeners();
    }

    void copyToClipboard() {
      if (text != null && text!.isNotEmpty) {
        Clipboard.setData(ClipboardData(text: text!));
      }
    }
  }
}