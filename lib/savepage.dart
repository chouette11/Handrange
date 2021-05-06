import 'package:flutter/material.dart';
import 'package:handrange/save.dart';
import 'package:handrange/sql.dart';
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
      Container(
        child: Consumer<Light>(builder: (context, model, child) {
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
                body:SaveGraphs()
            );
        }),
      );
  }
}

class SaveGraphs extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screensizewidth = MediaQuery.of(context).size.width;
    return
      Container(
          width: screensizewidth,
          child: Consumer<Light>(builder: (context, model, child) {
            return
              GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.001,
                  crossAxisSpacing: 0.001,
                  childAspectRatio: 0.8,
                  children: model.numbers.map((e) => GridTile(
                    child: List(id: e["id"],num: e["num"], name: e["name"], count: e["count"]),
                  ),
                  ).toList()
              );
          }
          )
      );
  }
}

class List extends StatelessWidget {
  final myController = TextEditingController();
  List({Key key, this.id, this.num, this.name, this.count}) : super(key: key);
  int id;
  int num;
  String name;
  int count;
  @override
  Widget build(BuildContext context) {
    // double screensizewidth = MediaQuery.of(context).size.width;
    return
      Container(
          child: Consumer<Light>(builder: (context, model, child) {
            return
              GestureDetector(
                onTap: () =>{
                  model.onGet(num,name),
                  Navigator.pushNamed(context, '/')
                },
                onLongPress: () => {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('${name}'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () async {
                                await Graph.deleteGraph(Graph(id:id));
                                await model.createGraphs();
                                Navigator.pop(context);

                                print("${id}");
                              },
                              child: const Text('削除'),
                            ),
                            SimpleDialogOption(
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
                                              await Graph.updateGraph(Graph(name: myController.text));
                                              await myController.clear();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                );
                                await model.createGraphs();
                                Navigator.pop(context); },
                              child: const Text('名前の変更'),
                            ),
                          ],
                        );
                      }
                  )
                },
                child:Column(
                  children: [
                    GridView.count(
                        crossAxisCount: 13,
                        mainAxisSpacing: 0.001,
                        crossAxisSpacing: 0.001,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: model.TFs[num].map((e) => GridTile(
                          child: Box(isSelected: e["isSelected"]),
                        ),
                        ).toList()
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text(
                              "VPIP ${((count / 1326) * 100).toStringAsFixed(2)}%"
                          ),
                          Text(
                              name
                          ),
                        ],
                      ),
                    )
                  ],
                ) ,
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
      return
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          ),
        );
  }
}
