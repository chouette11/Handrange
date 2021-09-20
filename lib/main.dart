import 'package:flutter/material.dart';
import 'calculates/equity/equity_page.dart';
import 'make/make_page.dart';
import 'calculates/equity/models/equity_page_model.dart';
import 'data/initsql.dart';
import 'calculates/hand/models/hand_page_model.dart';
import 'save/save_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'make/models/make_page_model.dart';
import 'calculates/hand/hand_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad/ad_state.dart';
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
  final Future<List<InitGraph>> initGraphs = InitGraph.getInitGraph();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initGraphs,
        builder: (BuildContext context, AsyncSnapshot<List<InitGraph>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              snapshot.data!.add(
                InitGraph(
                    id: 0,
                    text:"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
                    name: "noName1",
                    count: 0),
              );
              snapshot.data!.add(
                InitGraph(
                    id: 1,
                    text:"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
                    name: "noName2",
                    count: 0),
              );
              snapshot.data!.add(
                InitGraph(
                    id: 2,
                    text:"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
                    name: "noName3",
                    count: 0),
              );
              print(snapshot.data);
            }
            return Provider<List<InitGraph>?>.value(
              value: snapshot.data,
              child: ChangeNotifierProvider<MakePageModel>(
                create: (_) => MakePageModel(),
                child: ChangeNotifierProvider<HandPageModel>(
                  create: (_) => HandPageModel(),
                  child: ChangeNotifierProvider<EquityPageModel>(
                    create: (_) => EquityPageModel(),
                    child: MaterialApp(
                      title: 'HandRange',
                      theme: ThemeData(
                        primarySwatch: Colors.lightBlue,
                      ),
                      initialRoute: '/',
                      routes: {
                        '/': (context) => MakeRangePage(),
                        '/save': (context) => SavePage(),
                        '/calculate': (context) => CalculatePage(),
                        '/equity': (context) => EquityPage(),
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          else {
            return MaterialApp(
              home: Scaffold(
                body: Container(
                  child:Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text(
                            "読み込み中です",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                            "しばらくお待ち下さい",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}