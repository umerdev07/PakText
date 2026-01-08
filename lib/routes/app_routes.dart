import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/home/home_screen.dart';
import '../features/scan/scan_screen.dart';
import '../features/result/result_screen.dart';
import '../features/history/history_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String scan = '/scan';
  static const String result = '/result';
  static const String history = '/history';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case scan:
        return MaterialPageRoute(builder: (_) => const ScanScreen());
      case result:
        final text = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ResultScreen(text: text));
      case history:
        return MaterialPageRoute(builder: (_) => const HistoryScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
