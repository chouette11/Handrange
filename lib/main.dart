import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:handrange/creategraph.dart';
import 'package:handrange/drawer.dart';
import 'package:handrange/initsql.dart';
import 'package:handrange/savepage.dart';
import 'package:handrange/sql.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/calculatepage.dart';
import 'package:handrange/selectcardpage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:handrange/ad_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
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
                    '/': (context) => MyHomePage(),
                    '/save': (context) => SavePage(),
                    '/calculate': (context) => CalculatePage(),
                    '/select': (context) => SelectPage(),
                  },
                ),
              )
          )
      );
  }
}

class MyHomePage extends StatelessWidget{
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Scaffold(
              appBar: AppBar(
                title: Text('HandRange'),
              ),
              drawer: returnDrawer(context),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child:
                    Text(
                      model.graphName,
                      style: TextStyle(
                        fontFamily: "Sans",
                      ),
                    ),
                  ),
                  DisplayGraph(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                          child: Text('A'),
                          onPressed: () {
                            model.onHighs('A');
                          }),
                      RaisedButton(
                          child: Text('K'),
                          onPressed: () {
                            model.onHighs('K');
                          }),
                      RaisedButton(
                          child: Text('Q'),
                          onPressed: () {
                            model.onHighs('Q');
                          }),
                      RaisedButton(
                          child: Text('J'),
                          onPressed: () {
                            model.onHighs('J');
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                          child: Text('Pockets'),
                          onPressed: () {
                            model.onPocket();
                          }),
                      RaisedButton(
                          child: Text('クリア'),
                          onPressed: () {
                            model.onClear();
                          }),
                      RaisedButton(
                          child: Text('保存'),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("新規ハンドレンジ作成"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('名前を入力してね'),
                                      TextFormField(controller: myController),
                                      RaisedButton(
                                        child: Text('実行'),
                                        onPressed: () async {
                                          String name;
                                          name = myController.text;
                                          myController.clear();
                                          await saveGraph(model.status, name, model.count);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }),
                      RaisedButton(
                          onPressed: (){
                            updateGraph(model.status, model.graphId, model.graphCount, model.graphName);
                          },
                          child: Text("更新")
                      )
                    ],
                  ),
                  Row(
                    children: [
                      RaisedButton(
                          onPressed: () async{
                           await model.getInitGraph(0);
                          },
                          child: Text("UTG")
                      ),
                      RaisedButton(
                          onPressed: () async {
                            await model.getInitGraph(1);
                          },
                          child: Text("HJ")),
                      RaisedButton(
                          onPressed: () async {
                            await model.getInitGraph(2);
                          },
                          child: Text("CO")),
                      RaisedButton(
                          onPressed: () async {
                            await model.getInitGraph(3);
                          },
                          child: Text("BTN")),
                    ],
                  ),
                  TextField(),
                ],
              )
          );
      });
  }
}
//=============================================================================
// 表示
class TextField extends StatefulWidget {
  @override
  _TextFiledState createState() => _TextFiledState();
}
class _TextFiledState extends State<TextField> {
  @override
  Widget build(BuildContext context) {
    return
      Expanded(
          child:Consumer<Light>(builder: (context, model, child) {
            return
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'VPIP: ${((model.count / 1326) * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  BottomAd()
                ],
              );
          }
          )
      );
  }
}

class DisplayGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child: Consumer<Light>(
        builder: (context, model, child) {
          return GridView.count(
              crossAxisCount: 13,
              mainAxisSpacing: 0.001,
              crossAxisSpacing: 0.001,
              children: model.status.map((e) => GridTile(
                child: TapBox(hand: e["hand"], isSelected: e["isSelected"]),
              ),
              ).toList()
          );
        },
      ),
    );
  }
}

class TapBox extends StatelessWidget {
  TapBox( {Key key, this.hand, this.isSelected }) : super(key: key);
  String hand;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width / 29;
    return Consumer<Light>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          model.onTapped(hand);
        },
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.white),
              color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
            ),
            child:Center(
              child:
              Text(
                hand,
                style: TextStyle(
                    fontFamily: "Sans",
                    fontSize: boxWidth
                ),
              ),
            )
        ),
      );
    });
  }
}

