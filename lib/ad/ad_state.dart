import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3443545166967285/6738424627'
      : 'ca-app-pub-3443545166967285/1447892317';

  static String get popAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3443545166967285/6738424627'
      : 'ca-app-pub-3443545166967285/5896551010';

  static final BannerAdListener bannerListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

String unitId(String adUnitId) {
  var isRelease = const bool.fromEnvironment('dart.vm.product');

  if (isRelease) {
    return adUnitId;
  } else {
    return "ca-app-pub-3940256099942544/6300978111";
  }
}
