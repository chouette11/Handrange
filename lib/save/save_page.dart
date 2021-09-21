import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/rangeList.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/components/widgets/tapbox.dart';
import 'package:handrange/data/initsql.dart';
import 'package:handrange/data/sql.dart';
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
      backgroundColor: Colors.white,
      body: RangeList(
        range: context.select<MakePageModel, List<Map<String, dynamic>>>
          ((MakePageModel model) => model.status),
        padding: EdgeInsets.all(4),
        mainAxisSpacing: 4.5,
        crossAxisSpacing: 1.5,
        childAspectRatio: 0.8,
      ),
    );
  }
}

class SavedRange extends StatelessWidget {
  SavedRange({Key? key, required this.id, required this.num, required this.name, required this.count, required this.text}) : super(key: key);
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
                          return SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                child:Text("UTG"),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:3, text: text, name: name, count: count));
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                              SimpleDialogOption(
                                child:Text("HJ"),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:4, text: text, name: name, count: count));
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                              SimpleDialogOption(
                                child:Text("CO"),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:5, text: text, name: name, count: count));
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                              SimpleDialogOption(
                                child:Text("BTN"),
                                onPressed: () async {
                                  await InitGraph.insertInitGraph(InitGraph(id:6, text: text, name: name, count: count));
                                  Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
                                },
                              ),
                            ],
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
        child: Material(
          elevation: 0.4,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border:Border.all(width: 1.5, color: Colors.black45),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: GridView.count(
                  crossAxisCount: 13,
                  mainAxisSpacing: 0.001,
                  crossAxisSpacing: 0.001,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: getIsSelected(text).map((e) =>
                      GridTile(
                        child: CustomTapBox(isSelected: e["isSelected"]),
                      ),
                  ).toList(),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border:Border.all(width: 1.5, color: Colors.black12),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white70,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text("VPIP ${((count / 1326) * 100).toStringAsFixed(2)}%"),
                        Text(name),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
