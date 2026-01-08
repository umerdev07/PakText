import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/paktext_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize(); // Initialize AdMob

  // Initialize Hive
  await Hive.initFlutter();

  // Open the box
  await Hive.openBox('historyBox');

  runApp(const PaktextApp());
}
