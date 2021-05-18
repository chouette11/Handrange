import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:handrange/drawer.dart';
import 'package:handrange/creategraph.dart';
import 'package:handrange/savepage.dart';
import 'package:handrange/selectcardpage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/sql.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Handrange',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: CalculatePage()
    );
  }
}

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Handrange'),
        ),
        drawer: returnDrawer(context),
        body: Calculate(),
      );
  }
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Calculation>(builder: (context, model, child) {
        return
          ListView(
            children: [
              Display(),
              CardBoxes(),
              ElevatedButton(
                  child: Text('グラフ判定'),
                  onPressed: () {
                    model.graphJudge();
                  }),
              ElevatedButton(
                  child: Text('クリア'),
                  onPressed: () {
                    model.num1 = null;
                    model.num2 = null;
                    model.num3 = null;
                    model.num4 = null;
                    model.num5 = null;
                    model.mark1 = null;
                    model.mark2 = null;
                    model.mark3 = null;
                    model.mark4 = null;
                    model.mark5 = null;
                  }),
              ElevatedButton(
                  child: Text('読み込み'),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: SavedGraphs(),
                        )
                    );
                  }),
              Result(),
            ],
          );
      });
  }
}

class Display extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child: Consumer<Calculation>(
        builder: (context, model, child) {
          return GridView.count(
              crossAxisCount: 13,
              mainAxisSpacing: 0.001,
              crossAxisSpacing: 0.001,
              children: model.status.map((e) => GridTile(
                child: TapBox(hand: e["hand"], isSelected: e["isSelected"]),
              ),
              ).toList()
          );
        },
      ),
    );
  }
}

class TapBox extends StatelessWidget {
  TapBox( {Key key, this.hand, this.isSelected }) : super(key: key);
  String hand;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<Calculation>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          model.onTapped(hand);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          ),
          child: Center(
            child: Text(
              hand,
            ),
          ),
        ),
      );
    });
  }
}

class CardBoxes extends StatelessWidget{

  Container returnContainer(int n, String m){
    Column returnCard(int number, String selectedMark){
      String returnText(int n) {
        if(n == null){
          return "";
        }
        else if(n == 13){
          return "K";
        }
        else if(n == 12) {
          return "Q";
        }
        else if(n == 11) {
          return "J";
        }
        else if(n == 10){
          return "T";
        }
        else{
          return "${n}";
        }
      }
      String returnMark(String m){
        if(m == null){
          return "";
        }
        else if(m == "s"){
          return "♠";
        }
        else if(m == "c"){
          return "♣";
        }
        else if(m == "h"){
          return "♥";
        }
        else if(m == "d"){
          return "♦";
        }
      }
      return
        Column(
          children: [
            Center(
              child: Text(
                returnText(number),
                style: TextStyle(fontSize: 23,fontFamily: "PTS"),
              ),
            ),
            Center(
                child: Text(
                  returnMark(selectedMark),
                  style: TextStyle(fontSize: 23,fontFamily: "PTS"),
                )
            ),
          ],
        );
    }

    return
      Container(
        color: n == null || m == null ? Colors.black26 : Colors.white,
        child: Container(
          width: 40,
          height: 65,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: returnCard(n, m),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<Calculation>(builder: (context, model, child) {
        return
          GestureDetector(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (_) => SelectPage()
              );
            },
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    returnContainer(model.num1, model.mark1),
                    returnContainer(model.num2, model.mark2),
                    returnContainer(model.num3, model.mark3),
                    returnContainer(model.num4, model.mark4),
                    returnContainer(model.num5, model.mark5),
                  ],
                )
            ),
          );
      });
  }
}

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Calculation>(builder: (context, model, child) {
        return
          Column(
            children: [
              Text("Royal combo:${model.royalStraightFlash} ${((model.royalStraightFlash / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("StraightFlush combo:${model.straightFlush} ${((model.straightFlush / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("FourCards combo:${model.fourCards} ${((model.fourCards / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("FullHouse combo:${model.fullHouse} ${((model.fullHouse / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("Flush combo:${model.flush} ${((model.flush / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("Straight combo:${model.straight} ${((model.straight / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("ThreeCards combo:${model.threeCards} ${((model.threeCards / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("TwoPair combo:${model.twoPair} ${((model.twoPair / model.sum) * 100).toStringAsFixed(2)}%"),
              Text("OnePair combo:${model.onePair} ${((model.onePair / model.sum) * 100).toStringAsFixed(2)}%"),
            ],
          );
      });
  }
}

class SavedGraphs extends StatefulWidget {
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
          child: Consumer<Calculation>(builder: (context, model, child) {
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
          })
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
      Container(
          child: Consumer<Calculation>(builder: (context, model, child) {
            return
              GestureDetector(
                onTap: () =>{
                  model.onGet(widget.num,widget.name),
                  Navigator.pushNamed(context, '/calculate')
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
          })
      );
  }
}

