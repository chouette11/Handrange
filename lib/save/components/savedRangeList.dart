import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/functions/creategraph.dart';
import 'package:handrange/data/sql.dart';
import 'package:handrange/save/save_page.dart';

class SavedRangeList extends StatefulWidget {

  @override
  _SavedRangeListState createState() => _SavedRangeListState();
}

class _SavedRangeListState extends State<SavedRangeList>{
  final Future<List<Graph>> rangeList = Graph.getGraph();

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: rangeList,
        builder: (BuildContext context, AsyncSnapshot<List<Graph>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(8),
              width: screenSizeWidth,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 0.81,
                children: getRangeListFromSQL(snapshot).map((e) =>
                    GridTile(
                      child: GraphList(
                        id: e['id'],
                        num: e['num'],
                        text: e["text"],
                        name: e["name"],
                        count: e["count"],
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
