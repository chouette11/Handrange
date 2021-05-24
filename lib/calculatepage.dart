import 'package:flutter/material.dart';
import 'package:handrange/bar_chart.dart';
import 'package:handrange/calculation.dart';
import 'package:handrange/creategraph.dart';
import 'package:handrange/drawer.dart';
import 'package:handrange/selectcardpage.dart';
import 'package:handrange/sql.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calculation',
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
      Container(
          child: Consumer<Light>(builder: (context, model, child) {
            return
              Scaffold(
                appBar: AppBar(
                  title: Text('Calculate'),
                ),
                drawer: returnDrawer(context),
                body: Calculate(),
              );
          })
      );
  }
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Consumer<Calculation>(builder: (context, model, child) {
          return
            ListView(
              children: [
                Display(),
                CardBoxes(),
                ElevatedButton(
                    child: Text('計算'),
                    onPressed: () {
                      model.graphJudge();
                      model.createComboList();
                    }),
                RaisedButton(
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
                RaisedButton(
                    child: Text('グラフ読み込み'),
                    onPressed: ()async{
                      await model.createComboList();
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: SaveGraphs(),
                          )
                      );
                    }),
                Result(),
              ],
            );
        }),
      );
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
    double boxWidth = MediaQuery.of(context).size.width / 29;
    return Consumer<Light>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          //TODO
          isSelected != isSelected;
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          ),
          child: Center(
            child:
            Text(
              hand,
              style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: boxWidth
              ),
            ),
          )
        ),
      );
    });
  }
}

class CardBoxes extends StatelessWidget{

  Container returnContainer(int n, String m){
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
      Container(
        child:Consumer<Calculation>(builder: (context, model, child) {
          return
            BarChartDemo(comboList:model.comboList);
        }),
      );

  }
}

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
            Widget gridView;
            if (snapshot.hasData){
              gridView =
                  GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.001,
                      crossAxisSpacing: 0.001,
                      childAspectRatio: 0.8,
                      children: getIds(snapshot).map((e) => GridTile(
                        child: GraphList(id: e["id"],num: e["num"], name: e["name"],),
                      ),
                      ).toList()
                  );
            }
            else if(snapshot.hasError){
              //TODO
            }
            else{
              //TODO
            }
            return
              Container(
                  width: screenSizeWidth,
                  child: gridView
              );
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
      Consumer<Calculation>(builder: (context, model, child) {
        return
          GestureDetector(
            onTap: () =>{
              model.onGet(num,name,),
              Navigator.pushNamed(context, '/calculate')
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
                    children: getTFs(text).map((e) => GridTile(
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
      });
  }
}

class Box extends StatelessWidget {
  Box( {Key key,  this.isSelected }) : super(key: key);
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.white),
              color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
            ),
          )
      );
  }
}
