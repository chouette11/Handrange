import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/equity/models/equity_page_model.dart';
import 'package:handrange/calculates/hand/models/hand_page_model.dart';
import 'package:provider/provider.dart';
import 'package:handrange/calculates/components/saved_range.dart';
import 'package:handrange/components/functions/creategraph.dart';
import 'package:handrange/data/sql.dart';

class AlertRangeList extends StatefulWidget {
  AlertRangeList({Key? key, required this.range}) : super(key: key);
  final List<Map<String, dynamic>> range;

  @override
  _AlertRangeListState createState() => _AlertRangeListState();
}

class _AlertRangeListState extends State<AlertRangeList>{
  final Future<List<Graph>> rangeList = Graph.getGraph();

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: rangeList,
        builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 2, right: 2.5, left: 2.5),
              width: screenSizeWidth,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 1,
                childAspectRatio: 0.75,
                children: getRangeListFromSQL(snapshot).map((e) =>
                    GridTile(
                      child: AlertSavedRange(
                        text: e["text"],
                        name: e["name"],
                        count: e["count"],
                        onPressed: () {
                          getRangeFromSQL(e['num'], widget.range, snapshot.data);
                          context.read<HandPageModel>().notifyListeners();
                          context.read<EquityPageModel>().notifyListeners();
                          Navigator.pop(context);
                        },
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
