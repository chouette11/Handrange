import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/drawer.dart';
import 'package:handrange/datas/sql.dart';
import 'package:handrange/functions/creategraph.dart';
import 'package:handrange/functions/elements.dart';
import 'package:handrange/pages/calculatepage.dart';
import 'package:handrange/pages/selectcardpage2.dart';
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
    return Container(
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
                        content: SaveGraphs(),
                      ),
                    );
                  },
                  child: Text("レンジ")
              ),
              CardBoxes(),
            ],
          ),
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
                  onPressed: () {},
                  child: Text("レンジ")
              ),
              CardBoxes(),
            ],
          ),
        ],
      ),
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
    return FutureBuilder(
        future: graphs,
        builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(left: 2.5,right: 2.5,top: 2),
              width: screenSizeWidth,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 0.001,
                crossAxisSpacing: 2.5,
                childAspectRatio: 0.83,
                children: getIds(snapshot).map((e) =>
                    GridTile(
                      child: GraphList(
                          id: e["id"],
                          num: e["num"],
                          text: e["text"],
                          name: e["name"],
                          count: e["count"]
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
  GraphList({Key? key, required this.id, required this.num, required this.name, required this.count, required this.text}) : super(key: key);
  final int id;
  final int num;
  final String name;
  final int count;
  final String text;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<EqCalculation>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () => {
          model.onGet(num,name,),
          Navigator.pushNamed(context, '/equity'),
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
