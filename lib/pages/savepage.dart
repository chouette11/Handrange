import 'package:flutter/material.dart';
import '../functions/creategraph.dart';
import '../compornents/drawer.dart';
import '../sqls/sql.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../providers/light.dart';

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
                  title: Text('一覧'),
                ),
                drawer: returnDrawer(context),
                body:SaveGraphs()
            );
        }),
      );
  }
}

class SaveGraphs extends StatefulWidget {
  @override
  _SaveGraphsState createState() => _SaveGraphsState();
}
class _SaveGraphsState extends State<SaveGraphs>{
  final myController = TextEditingController();
  final Future<List<Graph>> graphs = Graph.getGraph();
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return
      FutureBuilder(
          future: graphs,
          builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
            if (snapshot.hasData){
              return
                Container(
                  margin: EdgeInsets.only(left: 2.5,right: 2.5,top: 2),
                  width: screenSizeWidth,
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.001,
                      crossAxisSpacing: 2.5,
                      childAspectRatio: 0.83,
                      children: getIds(snapshot).map((e) => GridTile(
                        child: GraphList(id: e["id"],num: e["num"], text: e["text"], name: e["name"], count: e["count"]),
                      ),
                      ).toList()
                  ),
                );
            }
            else if(snapshot.hasError){
              return
                  Center(
                    child: Text("Error"),
                  );
            }
            else{
              return
                Center(
                    child:
                    CircularProgressIndicator()
                );
            }
          }
      );
  }
}
class GraphList extends StatelessWidget {
  int id;
  int num;
  String name;
  int count;
  String text;
  GraphList({Key key, this.id, this.num, this.name, this.count, this.text}) : super(key: key);
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          GestureDetector(
            onTap: () =>{
              model.onGet(num,name,count),
              Navigator.pushNamed(context, '/'),
            },
            onLongPress: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text(name),
                      children: <Widget>[
                        SimpleDialogOption(
                          child: const Text('削除'),
                          onPressed: () async {
                            await Graph.deleteGraph(Graph(id:id));
                            Navigator.pop(context);
                          },
                        ),
                        SimpleDialogOption(
                          child: const Text('名前の変更'),
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text("名前の変更"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('名前の入力'),
                                      TextFormField(controller: myController),
                                      RaisedButton(
                                        child: Text('実行'),
                                        onPressed: () async {
                                          await Graph.updateGraph(Graph(id:id,text:text,name: myController.text,count:count));
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
            child: Column(
              children: [
                GridView.count(
                    crossAxisCount: 13,
                    mainAxisSpacing: 0.001,
                    crossAxisSpacing: 0.001,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: getTFs(text).map((e) => GridTile(
                      child: Box(isSelected: e["isSelected"]),
                    ),
                    ).toList()
                ),
                Center(
                  child: Column(
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
            ),
          );
      });
  }
}

class GraphRowLabel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: GridView.count(
            crossAxisCount: 13,
            mainAxisSpacing: 0.001,
            crossAxisSpacing: 0.001,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: labelList.map((e) => GridTile(
              child: LabelBox(num: e["num"],),
            ),
            ).toList()
        ),
      );
  }
}

class GraphColumnLabel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: GridView.count(
            crossAxisCount: 1,
            mainAxisSpacing: 0.001,
            crossAxisSpacing: 0.001,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: ColumnLabelList.map((e) => GridTile(
              child: LabelBox(num: e["num"],),
            ),
            ).toList()
        ),
      );
  }
}

class LabelBox extends StatelessWidget {
  LabelBox( {Key key, this.num}) : super(key: key);
  String num;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Text(num),
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
