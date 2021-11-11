import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:handrange/ad/ad_state.dart';

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