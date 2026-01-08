import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paktext/core/add/add_helper.dart';
import 'package:paktext/core/constraits/app_colors.dart';
import 'package:paktext/widgets/secondry_button.dart';
import 'package:paktext/widgets/primary_button.dart';
import 'package:paktext/widgets/loading_indicator.dart';
import 'package:paktext/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'scan_provider.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late BannerAd _topBanner;
  late BannerAd _bottomBanner;
  InterstitialAd? _interstitialAd;
  bool _isTopAdLoaded = false;
  bool _isBottomAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // Load banners
    _loadBannerAds();

    // Load interstitial
    _loadInterstitialAd();
  }

  void _loadBannerAds() {
    // Top Banner
    _topBanner = BannerAd(
      adUnitId: AddHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isTopAdLoaded = true),
        onAdFailedToLoad: (ad, error) {
          print('Top banner failed: $error');
          ad.dispose();
        },
      ),
    )..load();

    // Bottom Banner
    _bottomBanner = BannerAd(
      adUnitId: AddHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isBottomAdLoaded = true),
        onAdFailedToLoad: (ad, error) {
          print('Bottom banner failed: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AddHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Interstitial failed: $err');
        },
      ),
    );
  }

  void _showInterstitial(Function onAdClosed) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _loadInterstitialAd(); // preload next
          onAdClosed(); // navigate after ad
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          ad.dispose();
          _loadInterstitialAd();
          onAdClosed();
        },
      );

      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      // Ad not ready, navigate immediately
      onAdClosed();
    }
  }

  @override
  void dispose() {
    _topBanner.dispose();
    _bottomBanner.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScanProvider(),
      child: Consumer<ScanProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Scan Text',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.background,
            ),
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                // Top banner
                if (_isTopAdLoaded)
                  SizedBox(
                    width: _topBanner.size.width.toDouble(),
                    height: _topBanner.size.height.toDouble(),
                    child: AdWidget(ad: _topBanner),
                  ),

                // Main content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryButton(
                          text: 'Capture from Camera',
                          onPressed: () =>
                              provider.pickImageFromCamera(context),
                        ),
                        const SizedBox(height: 30),
                        PrimaryButton(
                          text: 'Pick from Gallery',
                          onPressed: () =>
                              provider.pickImageFromGallery(context),
                        ),
                        const SizedBox(height: 24),
                        if (provider.isLoading) const LoadingIndicator(),
                        if (!provider.isLoading &&
                            provider.extractedText.isNotEmpty)
                          SecondaryButton(
                            text: 'View Result',
                            onPressed: () {
                              // Show interstitial first
                              _showInterstitial(() {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.result,
                                  arguments: provider.extractedText,
                                );
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                // Bottom banner
                if (_isBottomAdLoaded)
                  SizedBox(
                    width: _bottomBanner.size.width.toDouble(),
                    height: _bottomBanner.size.height.toDouble(),
                    child: AdWidget(ad: _bottomBanner),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
