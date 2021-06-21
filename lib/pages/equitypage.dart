import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/datas/sql.dart';
import 'package:handrange/components//functions/creategraph.dart';
import 'package:handrange/components//functions/elements.dart';
import 'package:handrange/pages/calculatepage.dart';
import 'package:handrange/pages/selectholepage.dart';
import 'package:handrange/providers/eqcalculation.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Handrange',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: EquityPage()
    );
  }
}

class EquityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('エクイティ計算'),
        ),
        drawer: returnDrawer(context),
        body:Calculate()
    );
  }
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: HoleBoxes(),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("プレイヤー１")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: SaveGraphs(player: 1),
                          ),
                        );
                      },
                      child: Text("レンジ")
                  ),
                  DisplayGraph1(),
                  HoleBoxes(),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("プレイヤー２")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: SaveGraphs(player: 2,),
                          ),
                        );
                      },
                      child: Text("レンジ")
                  ),
                  DisplayGraph2(),
                  HoleBoxes(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EqCalculation>(builder: (context, model, child) {
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
                  CardBox(model.num1, model.mark1),
                  CardBox(model.num2, model.mark2),
                  CardBox(model.num3, model.mark3),
                  CardBox(model.num4, model.mark4),
                  CardBox(model.num5, model.mark5),
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

class Players extends StatelessWidget {
  Players({Key? key, required this.num}) : super(key: key);
  final int num;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("プレイヤー$num")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: SaveGraphs(player: num),
                    ),
                  );
                },
                child: Text("レンジ")
            ),
            num == 1 ? DisplayGraph1() : DisplayGraph2(),
            HoleBoxes(),
          ],
        ),
      ],
    );
  }
}

class DisplayGraph1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width / 4;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child: Consumer<EqCalculation>(builder: (context, model, child) {
        return GridView.count(
          crossAxisCount: 13,
          mainAxisSpacing: 0.001,
          crossAxisSpacing: 0.001,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: model.status1.map((e) =>
              GridTile(
                child: Box(isSelected: e["isSelected"]),
              ),
          ).toList(),
        );
      },
      ),
    );
  }
}

class DisplayGraph2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width / 4;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child: Consumer<EqCalculation>(builder: (context, model, child) {
        return GridView.count(
          crossAxisCount: 13,
          mainAxisSpacing: 0.001,
          crossAxisSpacing: 0.001,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: model.status2.map((e) =>
              GridTile(
                child: Box(isSelected: e["isSelected"]),
              ),
          ).toList(),
        );
      },
      ),
    );
  }
}

class SaveGraphs extends StatefulWidget {
  SaveGraphs({Key? key, required this.player}) : super(key: key);
  final int player;
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
              margin: EdgeInsets.only(left: 2.5,right: 2.5,top: 2),
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
                        name: e["name"],
                        count: e["count"],
                        player: widget.player,
                      ),
                    ),
                ).toList(),
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Error"));
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}

class GraphList extends StatelessWidget {
  GraphList({Key? key, required this.id, required this.num, required this.name, required this.count, required this.text, required this.player}) : super(key: key);
  final int id;
  final int num;
  final String name;
  final int count;
  final String text;
  final int player;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<EqCalculation>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () => {
          if (player == 1) {
            model.onGet1(num,name)
          }
          else if (player == 2) {
            model.onGet2(num,name)
          },
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
                    child: Box(isSelected: e["isSelected"]),
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
      ),
    );
  }
}

class HoleBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EqCalculation>(builder: (context, model, child) {
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
                  CardBox(model.num1_1, model.mark1_1),
                  CardBox(model.num1_2, model.mark1_2),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
