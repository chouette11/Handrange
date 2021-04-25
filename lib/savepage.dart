import 'package:flutter/material.dart';
import 'package:handrange/save.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Handrange',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: SavePage()
    );
  }
}

class SavePage extends StatelessWidget{
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
              children: <Widget>[
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
                ),
              ],
            ),
          ),
          body:SaveGraph()
      );
  }
}

class SaveGraph extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        double screensizewidth = MediaQuery.of(context).size.width;
        return
          Column(
              children:[
                List(),
                RaisedButton(
                    child: Text('表示'),
                    onPressed: () async {
                      print(model.TFs[0]);
                      await model.Creategraphs();
                    }),
                RaisedButton(
                    child: Text('消去'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("新規メモ作成"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('数字を入力してね'),
                                TextField(controller: myController),
                                RaisedButton(
                                  child: Text('実行'),
                                  onPressed: () async {
                                    model.onDelete(int.parse(myController.text));
                                    myController.clear();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ));
                    }),
              ]
          );
      }
      );
  }
}

class List extends StatelessWidget {

  List({Key key, this.id,}) : super(key: key);
  int id;
  @override
  Widget build(BuildContext context) {
    double screensizewidth = MediaQuery.of(context).size.width;
    return Container(
        width: screensizewidth,
        height: screensizewidth,
        child: Consumer<Light>(builder: (context, model, child) {
          return
            GridView.count(
                crossAxisCount: 13,
                mainAxisSpacing: 0.001,
                crossAxisSpacing: 0.001,
                children: model.TFs[0].map((e) => GridTile(
                  child: Box(isSelected: e["isSelected"]),
                ),
                ).toList()
            );
        })
    );
  }
}


class Box extends StatelessWidget {
  Box( {Key key,  this.isSelected }) : super(key: key);
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<Light>(builder: (context, model, child) {
      return
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          ),
        );
    }
    );
  }
}
