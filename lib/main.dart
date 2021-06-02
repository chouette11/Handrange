import 'package:flutter/material.dart';
import 'package:handrange/datas/sql.dart';
import 'package:handrange/pages/makepage.dart';
import 'providers/calculation.dart';
import 'functions/creategraph.dart';
import 'compornents/drawer.dart';
import 'pages/savepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'providers/light.dart';
import 'pages/calculatepage.dart';
import 'pages/selectcardpage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'compornents/ad_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ChangeNotifierProvider<Light>(
        create: (_) => Light(),//TODO load setting
        child:ChangeNotifierProvider<Calculation>(
          create: (_) => Calculation(),
          child:  MaterialApp(
            title: 'HandRange',
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => MakeRangePage(),
              '/save': (context) => SavePage(),
              '/calculate': (context) => CalculatePage(),
              '/select': (context) => SelectPage(),
            },
          ),
        ),
      ),
    );
  }
}
