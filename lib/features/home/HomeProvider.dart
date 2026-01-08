import 'package:flutter/cupertino.dart';

class Homeprovider extends ChangeNotifier{
  int scanCount = 0;

  void increment() {
    scanCount++;
    notifyListeners();
  }
}