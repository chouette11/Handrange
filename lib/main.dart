import 'package:flutter/material.dart';
import 'package:handrange/savepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/save.dart';
import 'dart:async';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handrange',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ChangeNotifierProvider<Light>(
          create: (_) => Light(),
          child: MyHomePage() ,
        ),
        '/next': (context) => ChangeNotifierProvider<Light>(
          create: (_) => Light(),
          child: SavePage(),
        )
      },
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
                  leading: Icon(Icons.message),
                  title: Text('Messages'),
                  onTap: () {
                    Navigator.pushNamed(context, '/next');
                  },
                ),

              ],
            ),
          ),
          body:Consumer<Light>(builder: (context, model, child) {
            return
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Keyboard(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                          child: Text('Pockets'),
                          onPressed: () {
                            model.onPocket();
                            model.Creategraphs();
                          }),
                      RaisedButton(
                          child: Text('A'),
                          onPressed: () {
                            model.onAhigh();
                          }),
                      RaisedButton(
                          child: Text('K'),
                          onPressed: () {
                            model.onKhigh();
                          }),
                      RaisedButton(
                          child: Text('読み込み1'),
                          onPressed: () async {
                            model.onGet1();
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                          child: Text('Q'),
                          onPressed: () {
                            model.onQhigh();
                          }),
                      RaisedButton(
                          child: Text('J'),
                          onPressed: () {
                            model.onJhigh();
                          }),
                      RaisedButton(
                          child: Text('保存'),
                          onPressed: () async {
                            model.onSave();
                          }),
                      RaisedButton(
                          child: Text('表示'),
                          onPressed: () async {
                            await model.Creategraphs();
                            print(model.TFs[0]);
                          }),
                    ],
                  ),
                  TextField(),
                ],
              );
          }
          )
      );
  }
}
//=============================================================================
// 表示
class TextField extends StatefulWidget {
  @override
  _TextFiledState createState() => _TextFiledState();
//static int _expression;
}
class _TextFiledState extends State<TextField> {
  // int _expression = 0;
  //
  // static final controller = StreamController<int>();
  // @override
  // void initState() {
  //   controller.stream.listen((event) => _UpdateText(event));
  // }
  //
  // void _UpdateText(int letter){
  //   setState(() {
  //     _expression += letter;
  //   });
  // }

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
//==============================================================================
// キーボード
class Keyboard extends StatelessWidget {

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
                child: TapBox(hand: e["hand"], value: e["value"], isSelected: e["isSelected"]),
              ),
              ).toList()
          );
        },
      ),
    );
  }
}

class TapBox extends StatelessWidget {
  TapBox( {Key key, this.hand, this.value, this.isSelected }) : super(key: key);
  String hand;
  int value;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<Light>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          // TODO: 個別に状態を変える
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

