import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:handrange/components/functions/elements.dart';

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

class BottomAd extends StatefulWidget {
  @override
  _BottomAdState createState() => _BottomAdState();
}

class _BottomAdState extends State<BottomAd> {
  late BannerAd _ad;

  @override
  void initState(){
    super.initState();
    _ad = BannerAd(
        adUnitId: unitId(AdState.bannerAdUnitId),
        size: AdSize.banner,
        request: AdRequest(),
        listener: AdState.bannerListener
    );

    _ad.load();
  }
  @override
  Widget build(BuildContext context) {
    double screenSizeHeight = MediaQuery.of(context).size.height;
    // ignore: unnecessary_null_comparison
    if(_ad == null)
      return SizedBox(height: 50);
    else
      return Container(
          width: _ad.size.width.toDouble(),
          height: _ad.size.height.toDouble(),
          child: AdWidget(ad: _ad),
        );
  }
}

class PopAd extends StatefulWidget {
  @override
  _PopAdState createState() => _PopAdState();
}

class _PopAdState extends State<PopAd> {
  late BannerAd _ad;
  @override
  void initState(){
    super.initState();
    _ad = BannerAd(
      adUnitId: unitId(AdState.popAdUnitId),
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: AdState.bannerListener,
    );

    _ad.load();
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if(_ad == null)
      return SizedBox(height: 100);
    else
      return Container(
        width: _ad.size.width.toDouble(),
        height: _ad.size.height.toDouble(),
        child: AdWidget(ad: _ad),
      );
  }
}
