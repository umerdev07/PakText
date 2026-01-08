import 'package:flutter/material.dart';
import '../../core/services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
    final StorageService _storageService = StorageService();
    List<Map<String, dynamic>> history = [];

    Future<void> loadHistory() async {
        history = await _storageService.getAllScans();
        notifyListeners();
    }
}
