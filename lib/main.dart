import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:handrange/drawer.dart';
import 'package:handrange/savepage.dart';
import 'package:handrange/sql.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/calculatepage.dart';
import 'package:handrange/selectcardpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
          child:ChangeNotifierProvider<Light>(
              create: (_) => Light(),
              child:ChangeNotifierProvider<Calculation>(
                create: (_) => Calculation(),
                child:  MaterialApp(
                  title: 'Handrange',
                  theme: ThemeData(
                    primarySwatch: Colors.lightBlue,
                  ),
                  initialRoute: '/',
                  routes: {
                    '/': (context) => MyHomePage() ,
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
                title: Text('Handrange'),
              ),
              drawer: returnDrawer(context),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Graph(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      lightButton('pocket', model.onPocket()),
                      lightButton('A', model.onHighs('A')),
                      lightButton('K', model.onHighs('K')),
                      lightButton('Q', model.onHighs('Q')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      lightButton('J', model.onHighs('J')),
                      lightButton('ALL', model.onAll()),
                      ElevatedButton(
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
                                      ElevatedButton(
                                        child: Text('実行'),
                                        onPressed: () async {
                                          String graphName = myController.text;
                                          myController.clear();
                                          await onSave(model.status,model.count,graphName);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                            );
                          }),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${((model.count / 1326) * 100).toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              );
          })
      );
  }
}

class Graph extends StatelessWidget {
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
          child: Center(
            child: Text(
              hand,
            ),
          ),
        ),
      );
    });
  }
}

