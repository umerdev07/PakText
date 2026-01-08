import 'package:hive/hive.dart';

class StorageService {
  final Box _box = Hive.box('historyBox');

  Future<void> saveScan(String text) async {
    await _box.add({
      'text': text,
      'date': DateTime.now().toString(),
    });
  }

  Future<List<Map<String, dynamic>>> getAllScans() async {
    return _box.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
