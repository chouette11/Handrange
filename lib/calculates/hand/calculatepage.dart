import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/cardbox.dart';
import 'package:handrange/components/widgets/bar_chart.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';
import 'package:handrange/datas/sql.dart';
import 'models/calculation.dart';
import '../../components/functions/creategraph.dart';
import '../../components/widgets/drawer.dart';
import '../../ad/popadpage.dart';
import 'selectboardpage1.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('計算'),
      ),
      drawer: returnDrawer(context),
      body: Calculate(),
    );
  }
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Calculation>(builder: (context, model, child) {
      return ListView(
        children: [
          HandRange(
            children: model.status.map((e) => GridTile(
              child: CustomTapBox(
                name: e["hand"],
                isSelected: e["isSelected"],
                onPressed: () {},
              ),
            )).toList(),
            size: 1,
          ),
          CardBoxes(),
          RaisedButton(
            child: Text('レンジ読み込み'),
            onPressed: () async {
              await model.createComboList();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: SaveGraphs(player: "",),
                ),
              );
            },
          ),
          ElevatedButton(
            child: Text('計算'),
            onPressed: () async {
              if (model.card3 == "") {
                showDialog(context: context,
                  builder: (_) => SimpleDialog(
                    title:Text("エラー"),
                    children: <Widget>[
                      SimpleDialogOption(
                        child: Text('ボードのカードを３枚以上選択してください'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
              else {
                showDialog(
                  context: context,
                  builder: (_) => PopAdPage(),
                );
                model.graphJudge();
                model.createComboList();
              }
            },
          ),
          Result(),
        ],
      );
    });
  }
}

class CardBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Calculation>(builder: (context, model, child) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => SelectPage(),
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardBox(model.num1, model.mark1),
                  cardBox(model.num2, model.mark2),
                  cardBox(model.num3, model.mark3),
                  cardBox(model.num4, model.mark4),
                  cardBox(model.num5, model.mark5),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text('クリア'),
                onPressed: () {
                  model.num1 = 0;
                  model.num2 = 0;
                  model.num3 = 0;
                  model.num4 = 0;
                  model.num5 = 0;
                  model.mark1 = "";
                  model.mark2 = "";
                  model.mark3 = "";
                  model.mark4 = "";
                  model.mark5 = "";
                  model.card1 = "";
                  model.card2 = "";
                  model.card3 = "";
                  model.card4 = "";
                  model.card5 = "";
                  model.onReset();
                  model.notifyListeners();
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      child:Consumer<Calculation>(builder: (context, model, child) {
        return Visibility(
            visible: model.isVisible,
            child: BarChart(comboList:model.comboList, onePairList: model.onePairList,)
        );
      }),
    );
  }
}

class SaveGraphs extends StatefulWidget {
  SaveGraphs({Key? key, required this.player}) : super(key: key);
  final String player;
  @override
  _SaveGraphsState createState() => _SaveGraphsState();
}

class _SaveGraphsState extends State<SaveGraphs>{
  final myController = TextEditingController();
  final Future<List<Graph>> graphs = Graph.getGraph();

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: graphs,
      builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: screenSizeWidth,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0.5,
              crossAxisSpacing: 1,
              childAspectRatio: 0.75,
              children: getIds(snapshot).map((e) =>
                  GridTile(
                    child: GraphList(
                        id: e["id"],
                        num: e["num"],
                        text: e["text"],
                        name: widget.player,
                        count: e["count"]),
                  ),
              ).toList(),
            ),
          );
        }
        else if (snapshot.hasError) {
          return Center(
            child: Text(widget.player),
          );
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
    return Consumer<Calculation>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () => {
          model.onGet(num, name),
          Navigator.pop(context),
        },
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 13,
              mainAxisSpacing: 0.001,
              crossAxisSpacing: 0.001,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: getTFs(text).map((e) =>
                  GridTile(
                    child: CustomTapBox(isSelected: e["isSelected"]),
                  ),
              ).toList(),
            ),
            Center(
              child: Column(
                children: [
                  Text("VPIP ${((count / 1326) * 100).toStringAsFixed(2)}%"),
                  Text(name),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class Box extends StatelessWidget {
  Box( {Key? key,  required this.isSelected }) : super(key: key);
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.white),
          color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
        ),
      ),
    );
  }
}
