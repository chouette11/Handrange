import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:handrange/ad/ad_state.dart';

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
      adUnitId: unitId(AdState.bannerAdUnitId),
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: AdState.bannerListener,
    );

    _ad.load();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ad.size.width.toDouble(),
      height: _ad.size.height.toDouble(),
      child: AdWidget(ad: _ad),
    );
  }
}