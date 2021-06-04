import 'package:flutter/material.dart';
import 'package:handrange/pages/equitypage.dart';
import 'package:handrange/pages/makepage.dart';
import 'package:handrange/providers/eqcalculation.dart';
import 'providers/calculation.dart';
import 'pages/savepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'providers/light.dart';
import 'pages/calculatepage.dart';
import 'pages/selectcardpage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'components/widgets/ad_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    return ChangeNotifierProvider<Light>(
        create: (_) => Light(),
        child:ChangeNotifierProvider<Calculation>(
          create: (_) => Calculation(),
          child:ChangeNotifierProvider<EqCalculation>(
            create: (_) => EqCalculation(),
            child:MaterialApp(
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
                '/equity' : (context) => EquityPage(),
              },
            ),
          ),
        ),
      );
  }
}
