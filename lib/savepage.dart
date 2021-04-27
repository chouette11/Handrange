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
                          await model.Creategraphs();
                          await Navigator.pushNamed(context, '/next');
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
                    child: List(id: e["id"]),
                  ),
                  ).toList()
              );
          }
          )
      );
  }
}

class List extends StatelessWidget {

  List({Key key, this.id,}) : super(key: key);
  int id;
  @override
  Widget build(BuildContext context) {
    // double screensizewidth = MediaQuery.of(context).size.width;
    return
      Container(
          child: Consumer<Light>(builder: (context, model, child) {
            return
              GestureDetector(
                onTap: () =>{
                  model.onGet(id),
                  Navigator.pushNamed(context, '/')
                },
                onLongPress: () => {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: Text('Graph${id}'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () async {
                                await model.onDelete(id);
                                print("${id}");
                              },
                              child: const Text('削除'),
                            ),
                            SimpleDialogOption(
                              onPressed: () { Navigator.pop(context); },
                              child: const Text('State department'),
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
                        children: model.TFs[id].map((e) => GridTile(
                          child: Box(isSelected: e["isSelected"]),
                        ),
                        ).toList()
                    ),
                    Text(
                        "graph${id}"
                    ),
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
