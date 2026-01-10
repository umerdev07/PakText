import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:paktext/core/constraits/app_colors.dart';
import 'package:paktext/core/constraits/app_fonts.dart';
import 'package:paktext/core/constraits/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // AdMob (non-blocking)
    MobileAds.instance.initialize();

    // Hive (safe)
    if (!Hive.isBoxOpen('historyBox')) {
      await Hive.initFlutter();
      await Hive.openBox('historyBox');
    }

    // Splash delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/home');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 5),
            Text(
              AppStrings.splashTitle,
              style: AppFonts.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
