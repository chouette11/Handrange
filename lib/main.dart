import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:handrange/savepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/calculatepage.dart';
import 'package:handrange/save.dart';

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
      Container(
        child:Consumer<Light>(builder: (context, model, child) {
          return
            Scaffold(
                appBar: AppBar(
                  title: Text('Handrange'),
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children:  <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Drawer Header',
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
                        onTap: () async {
                          await model.createGraphs();
                          await Navigator.pushNamed(context, '/save');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.file_copy),
                        title: Text('Calculate'),
                        onTap: () async {
                          await model.createGraphs();
                          await Navigator.pushNamed(context, '/calculate');
                        },
                      ),
                    ],
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      model.graphName
                    ),
                    Graph(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                            child: Text('Pockets'),
                            onPressed: () {
                              model.onPocket();
                            }),
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
                            child: Text('All'),
                            onPressed: () {
                              model.onAll();
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                        RaisedButton(
                            child: Text('保存'),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("新規メモ作成"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('名前を入力してね'),
                                        TextFormField(controller: myController),
                                        RaisedButton(
                                          child: Text('実行'),
                                          onPressed: () async {
                                            model.name = myController.text;
                                            myController.clear();
                                            await model.onSave();
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
        }) ,
      );
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
          }
          )
      );
  }
}

class Graph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screensizewidth = MediaQuery.of(context).size.width;
    return Container(
      width: screensizewidth,
      height: screensizewidth,
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

