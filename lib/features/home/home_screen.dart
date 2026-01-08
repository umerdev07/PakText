import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paktext/core/add/add_helper.dart';
import 'package:paktext/features/home/HomeProvider.dart';
import 'package:provider/provider.dart';
import 'package:paktext/core/constraits/app_colors.dart';
import 'package:paktext/core/constraits/app_strings.dart';
import 'package:paktext/routes/app_routes.dart';
import 'package:paktext/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _topBanner;
  late BannerAd _bottomBanner;
  bool _isTopAdLoaded = false;
  bool _isBottomAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // Initialize Top Banner
    _topBanner = BannerAd(
      adUnitId: AddHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isTopAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Top banner failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();

    // Initialize Bottom Banner
    _bottomBanner = BannerAd(
      adUnitId: AddHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Bottom banner failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _topBanner.dispose();
    _bottomBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        centerTitle: true,
        actionsPadding: const EdgeInsets.all(20),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Top banner ad
          if (_isTopAdLoaded)
            SizedBox(
              width: _topBanner.size.width.toDouble(),
              height: _topBanner.size.height.toDouble(),
              child: AdWidget(ad: _topBanner),
            ),

          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    text: 'Scan Text',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.scan);
                    },
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    text: 'Scan History (${homeProvider.scanCount})',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.history);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom banner ad
          if (_isBottomAdLoaded)
            SizedBox(
              width: _bottomBanner.size.width.toDouble(),
              height: _bottomBanner.size.height.toDouble(),
              child: AdWidget(ad: _bottomBanner),
            ),
        ],
      ),
    );
  }
}
