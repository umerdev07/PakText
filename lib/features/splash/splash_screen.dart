import 'package:flutter/material.dart';
import 'package:paktext/core/constraits/app_colors.dart';
import 'package:paktext/core/constraits/app_fonts.dart';
import 'package:paktext/core/constraits/app_strings.dart';
import 'package:paktext/widgets/primary_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png', width: 200, height: 200),
            SizedBox(height: 10),
            Text(
              AppStrings.splashTitle,

              style: AppFonts.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            PrimaryButton(
              text: 'Get Started',
              width: 350,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          ],
        ),
      ),
    );
  }
}
