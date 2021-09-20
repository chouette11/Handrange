import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/saved_range.dart';
import 'package:handrange/components/functions/creategraph.dart';
import 'package:handrange/data/sql.dart';

class RangeList extends StatefulWidget {
  RangeList({Key? key, required this.range}) : super(key: key);
  final List<Map<String, dynamic>> range;
  @override
  _RangeListState createState() => _RangeListState();
}

class _RangeListState extends State<RangeList>{
  final Future<List<Graph>> rangeList = Graph.getGraph();

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: rangeList,
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
                children: getRangeListFromSQL(snapshot).map((e) =>
                    GridTile(
                      child: SavedRange(
                        num: e["num"],
                        text: e["text"],
                        name: e["name"],
                        count: e["count"],
                        onPressed: () {
                          getRangeFromSQL(e['id'], widget.range, snapshot.data);
                          Navigator.pop(context);
                        }
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
