import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:handrange/ad_state.dart';

Drawer returnDrawer(BuildContext context,) {
  return
  Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'メニュー',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.graphic_eq_sharp),
          title: Text('Graphs'),
          onTap: ()  {
             Navigator.pushNamed(context, '/save');
          },
        ),
        ListTile(
          leading: Icon(Icons.file_copy),
          title: Text('Calculate'),
          onTap: ()  {
            Navigator.pushNamed(context, '/calculate');
          },
        ),
      ],
    ),
  );
}

class BottomAd extends StatefulWidget{
  @override
  _BottomAdState createState() => _BottomAdState();
}

class _BottomAdState extends State<BottomAd> {
  BannerAd _ad;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ad = BannerAd(
        adUnitId: AdState.bannerAdUnitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: AdState.listener
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    if(_ad == null)
      return
      SizedBox(height: 50,);
    else
      return
      Container(
          width: _ad.size.width.toDouble(),
          height: _ad.size.height.toDouble(),
          child: AdWidget(ad: _ad)
      );
  }
}