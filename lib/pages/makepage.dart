import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/datas/sql.dart';
import 'package:handrange/providers/light.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MakeRangePage(),
    );
  }
}

class MakeRangePage extends StatelessWidget{
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<Light>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("レンジ作成"),
        ),
        drawer: returnDrawer(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                model.graphName,
                style: TextStyle(
                  fontFamily: "Sans",
                ),
              ),
            ),
            DisplayGraph(),
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                    child: Text('Pockets'),
                    onPressed: () {
                      model.onPocket();
                    }
                ),
                RaisedButton(
                    child: Text('クリア'),
                    onPressed: () {
                      model.onClear();
                    }
                ),
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
                        ),
                      );
                    }
                ),
                ElevatedButton(
                    onPressed: () {
                      updateGraph(model.status, model.graphId, model.graphCount, model.graphName);
                    },
                    child: Text("更新")
                ),
              ],
            ),
            TextField(),
          ],
        ),
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
    return Expanded(
      child:Consumer<Light>(builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              ),
            ),
          ],
        );
      }),
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
      child: Consumer<Light>(builder: (context, model, child) {
          return GridView.count(
            crossAxisCount: 13,
            mainAxisSpacing: 0.001,
            crossAxisSpacing: 0.001,
            children: model.status.map((e) => GridTile(
              child: TapBox(hand: e["hand"], isSelected: e["isSelected"]),
            ),
            ).toList(),
          );
        },
      ),
    );
  }
}

class TapBox extends StatelessWidget {
  TapBox( {Key? key, required this.hand, required this.isSelected }) : super(key: key);
  final String hand;
  final bool isSelected;

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
            child: Text(
              hand,
              style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: boxWidth
              ),
            ),
          ),
        ),
      );
    });
  }
}
