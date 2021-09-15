import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/cardbox.dart';
import 'package:handrange/calculates/equity/components/player.dart';
import 'package:handrange/components/functions/creategraph.dart';
import 'package:handrange/components/saved_range.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/datas/sql.dart';
import 'models/calculation_model.dart';
import 'select_page.dart';
import 'models/equity_page_model.dart';
import 'package:provider/provider.dart';

class EquityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('エクイティ計算'),
        ),
        drawer: returnDrawer(context),
        body: Consumer<EquityPageModel>(builder: (context, model, child) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: BoardBoxes(),
              ),
              Expanded(
                flex: 2,
                child: Player(num: 1, cardHole: model.cardHole1, range: model.status1),
              ),
              Expanded(
                flex: 2,
                child: Player(num: 2, cardHole: model.cardHole2, range: model.status2),
              ),
            ],
          );
        }),
    );
  }
}

class BoardBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EquityPageModel>(builder: (context, model, child) {

      List<Widget> cardBoxes = <Widget>[
        cardBox(null, null),
        cardBox(null, null),
        cardBox(null, null),
        cardBox(null, null),
        cardBox(null, null),
      ];

      var index = 0;
      if (index < 5) {
        model.boardCard.forEach((element) {
          int? num;
          String? mark;
          List<String> split = element.split('');
          if (split.length == 2) {
            num = int.parse(split[0]);
            mark = split[1];
          } else if (split.length == 3) {
            mark = split[2];
            split.removeLast();
            num = int.parse(split.join());
          }
          cardBoxes[index] = cardBox(num, mark);
          index++;
        });
      }

      return Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => SelectPageEq(name: "board"),
              );
              print(model.board);
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: cardBoxes
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text('クリア'),
                onPressed: () => model.onClear(),
              ),
              RaisedButton(
                child: Text('計算'),
                  onPressed: () {
                    print('${winPlayer(handJudge(addInt(model.numHole1, model.board), addHand(model.markHole1, model.boardMark), addHand(model.cardHole1, model.boardCard)),
                        handJudge(addInt(model.numHole2, model.board), addHand(model.markHole2, model.boardMark), addHand(model.cardHole2, model.boardCard)))}');
                  }
              )
            ],
          ),
        ],
      );
    });
  }
}

class GraphList extends StatefulWidget {
  GraphList({Key? key, required this.player, required this.range}) : super(key: key);
  final int player;
  final List<Map<String, dynamic>> range;
  @override
  _GraphListState createState() => _GraphListState();
}

class _GraphListState extends State<GraphList>{
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
                      child: SavedRange(
                        num: e["num"],
                        text: e["text"],
                        name: e["name"],
                        count: e["count"],
                        onPressed: () => onGetRange(e['id'], widget.range, snapshot.data),
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
