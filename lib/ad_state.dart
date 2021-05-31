import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3443545166967285/8508933181';

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

  static String get nativeAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3443545166967285/8508933181';

  static final NativeAdListener nativeListener = NativeAdListener(
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

class NativeAdWidget extends StatefulWidget {
  @override
  _NativeAdWidgetState createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd _ad;

  void initState() {
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdState.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: AdState.nativeListener
    );

    _ad.load();
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: AdWidget(ad: _ad),
        height: 72.0,
          alignment: Alignment.center
      );
  }
}

class PopAd extends StatefulWidget {
  @override
  _PopAdState createState() => _PopAdState();
}

class _PopAdState extends State<PopAd> {
  BannerAd _ad;

  @override
  void initState(){
    super.initState();

    _ad = BannerAd(
        adUnitId: AdState.bannerAdUnitId,
        size: AdSize.largeBanner,
        request: AdRequest(),
        listener: AdState.bannerListener
    );

    _ad.load();
  }
  @override
  Widget build(BuildContext context) {
    if(_ad == null)
      return
          SizedBox(height: 100);
    else
      return
         Container(
           width: _ad.size.width.toDouble(),
           height: _ad.size.height.toDouble(),
           child: AdWidget(ad: _ad),
         );
  }
}

class BottomAd extends StatefulWidget {
  @override
  _BottomAdState createState() => _BottomAdState();
}

class _BottomAdState extends State<BottomAd> {
  BannerAd _ad;

  @override
  void initState(){
    super.initState();

    _ad = BannerAd(
        adUnitId: AdState.bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: AdState.bannerListener
    );

    _ad.load();
  }
  @override
  Widget build(BuildContext context) {
    if(_ad == null)
      return
        SizedBox(height: 50);
    else
      return
        Container(
          width: _ad.size.width.toDouble(),
          height: _ad.size.height.toDouble(),
          child: AdWidget(ad: _ad),
        );
  }
}