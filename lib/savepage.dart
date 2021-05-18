import 'package:flutter/material.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/drawer.dart';
import 'package:handrange/creategraph.dart';
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
      Scaffold(
          appBar: AppBar(
            title: Text('Handrange'),
          ),
          drawer: returnDrawer(context),
          body:SaveGraphs()
      );
  }
}

class SaveGraphs extends StatefulWidget {
  @override
  _SaveGraphsState createState() => _SaveGraphsState();
}
class _SaveGraphsState extends State<SaveGraphs>{
  List<Graph> graphs;
  List <Map<String,dynamic>> ids = [];
  final myController = TextEditingController();

  @override
  Future<void> initState() async {
    super.initState();
    graphs = await Graph.getGraph();
    ids = getIds(graphs);
  }

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return
      Container(
          width: screenSizeWidth,
          child: Consumer<Light>(builder: (context, model, child) {
            return
              GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.001,
                  crossAxisSpacing: 0.001,
                  childAspectRatio: 0.8,
                  children: ids.map((e) => GridTile(
                    child: GraphList(id: e["id"],num: e["num"], name: e["name"], count: e["count"]),
                  ),
                  ).toList()
              );
          }
          )
      );
  }
}

class GraphList extends StatefulWidget {
  int id;
  int num;
  String name;
  int count;
  GraphList({Key key, this.id, this.num, this.name, this.count}) : super(key: key);
  @override
  _GraphList createState() => _GraphList();
}
class _GraphList extends State<GraphList>{
  List<Graph> graphs;
  List <List> TFs = [];
  final myController = TextEditingController();
  @override
  Future<void> initState() async {
    super.initState();
    graphs = await Graph.getGraph();
    TFs = getTFs(graphs);
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          GestureDetector(
            onTap: () =>{
              model.onGet(widget.num,widget.name),
              Navigator.pushNamed(context, '/')
            },
            onLongPress: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text(widget.name),
                      children: <Widget>[
                        SimpleDialogOption(
                          child: const Text('削除'),
                          onPressed: () async {
                            await Graph.deleteGraph(Graph(id:widget.id));
                            Navigator.pop(context);
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text('名前の変更'),
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
                                          myController.clear();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                            );
                            Navigator.pop(context);
                          },
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
                    children: TFs[widget.num].map((e) => GridTile(
                      child: Box(isSelected: e["isSelected"]),
                    ),
                    ).toList()
                ),
                Center(
                  child: Row(
                    children: [
                      Text(
                          "VPIP ${((widget.count / 1326) * 100).toStringAsFixed(2)}%"
                      ),
                      Text(
                          widget.name
                      ),
                    ],
                  ),
                )
              ],
            ) ,
          );
      });
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
