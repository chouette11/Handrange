import 'package:flutter/material.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';
import 'package:handrange/data/initsql.dart';
import 'package:handrange/data/sql.dart';
import 'package:handrange/save/components/savedRangeList.dart';
import '../components/functions/creategraph.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../make/models/make_page_model.dart';

class SavePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('一覧'),
        ),
        drawer: returnDrawer(context),
        backgroundColor: Colors.grey[400],
        body: SavedRangeList()
    );
  }
}

class GraphList extends StatelessWidget {
  GraphList({Key? key, required this.id, required this.num, required this.name, required this.count, required this.text}) : super(key: key);

  final int id;
  final int num;
  final String name;
  final int count;
  final String text;
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final initGraphs = Provider.of<List<InitGraph>?>(context);
    return Consumer<MakePageModel>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () => {
          model.onGet(num,name,count),
          Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false),
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
                      await Graph.deleteGraph(id);
                      Navigator.pushNamedAndRemoveUntil(context, '/save', (Route<dynamic> route) => false);
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
                                  Navigator.pushNamedAndRemoveUntil(context, '/save', (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                  SimpleDialogOption(
                    child: const Text('ポジションボタンのレンジ変更'),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          List<Widget> positionRanges = [];

                          Widget positionRange(String position, int id) {
                            return SimpleDialogOption(
                              child:Text(position),
                              onPressed: () async {
                                await InitGraph.insertInitGraph(InitGraph(id: id, text: text, name: name, count: count));
                                Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                              },
                            );
                          }

                          positionRanges.add(positionRange("UTG", 3));
                          positionRanges.add(positionRange("HJ", 4));
                          positionRanges.add(positionRange("CO", 5));
                          positionRanges.add(positionRange("BTN", 6));

                          return SimpleDialog(
                              children: positionRanges
                          );
                        },
                      );
                    },
                  ),
                  SimpleDialogOption(
                    child: const Text('ボタンにレンジを保存'),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                child:Text(
                                    model.isNames[0] ? model.initGraphName[0] : initGraphs![0].name
                                ),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:0, text: text, name: name, count: count));
                                  model.changeName(name, 0);
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                              SimpleDialogOption(
                                child:Text(
                                    model.isNames[1] ? model.initGraphName[1] : initGraphs![1].name
                                ),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:1, text: text, name: name, count: count));
                                  model.changeName(name, 1);
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                              SimpleDialogOption(
                                child:Text(
                                    model.isNames[2] ? model.initGraphName[2] : initGraphs![2].name
                                ),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:2, text: text, name: name, count: count));
                                  model.changeName(name, 2);
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        },
        child: Column(
          children: [
            Material(
              elevation: 0.4,
              child: Container(
                decoration: BoxDecoration(
                  border:Border.all(width: 2.0, color: Colors.black45),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: HandRange(
                  children: getIsSelected(text).map((e) =>
                      GridTile(
                        child: CustomTapBox(isSelected: e["isSelected"]),
                      ),
                  ).toList(),
                  size: 2.18,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.18,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "VPIP ${((count / 1326) * 100).toStringAsFixed(2)}%",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
