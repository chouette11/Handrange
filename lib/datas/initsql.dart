import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class InitGraph {
  final int id;
  final String text;
  final String name;
  final int count;

  InitGraph({required this.id, required this.text, required this.name, required this.count});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'name': name,
      'count' : count,
    };
  }
  @override
  String toString() {
    return 'InitGraph{id: $id, text: $text, name: $name count: $count}';
  }

  static Future<Database> get database async {
    String? path = await getDatabasesPath();
    final Future<Database> _database = openDatabase(
      join(path!, 'initGraph_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE initGraph(id INTEGER PRIMARY KEY, text TEXT, name TEXT, count INTEGER)"
        );
      },
      version: 1,
    );
    return _database;
  }

  static Future<void> insertInitGraph(InitGraph graph) async {
    final Database db = await database;
    await db.insert(
      'initGraph',
      graph.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<InitGraph>> getInitGraph() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('initGraph');
    if(maps.length == 0){
      await insertInitGraph(InitGraph(
          id:0,
          text:"TTTTTTTTTTTTTTTTTTTFFFFFFFTTTTTFFFFFFFFTTFTTTFFFFFFFTFFFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "UTG",
          count: 234)
      );
      await insertInitGraph(InitGraph(
          id:1,
          text:"TTTTTTTTTTTTTTTTTTTFFFFFFFTTTTTTFFFFFFFTTTTTTFFFFFFFTTFFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "HJ",
          count: 250)
      );
      await insertInitGraph(InitGraph(
          id:2,
          text:"TTTTTTTTTTTTTTTTTTTTTTFFFFTTTTTTTFFFFFFTTTTTTFFFFFFFTTTTTTTFFFFFFTFFFFTTTFFFFFFFFFFFTTFFFFFFFFFFFFTTFFFFFFFFFFFFTTFFFFFFFFFFFFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFT",
          name: "UTG",
          count: 342)
      );
      await insertInitGraph(InitGraph(
          id:3,
          text:"TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTFFFTTTTTTTTFFFFFTTTTTTTTFFFFFTTTTTTTTTFFFFTFFFFFTTTTFFFTFFFFFFTTTFFFTFFFFFFFTTTFFTFFFFFFFFTTFFTFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFT",
          name: "BTN",
          count: 462)
      );
    }
    return List.generate(maps.length, (i) {
      return InitGraph(
          id: maps[i]['id'],
          text: maps[i]['text'],
          name: maps[i]['name'],
          count: maps[i]['count']
      );
    });
  }

  static Future<void> updateInitGraph(InitGraph graph) async {
    final db = await database;
    await db.update(
      'initGraph',
      graph.toMap(),
      where: "id = ?",
      whereArgs: [graph.id],
    );
  }

  static Future<void> deleteInitGraph(InitGraph graph) async {
    final db = await database;
    await db.delete(
      'initGraph',
      where: "id = ?",
      whereArgs: [graph.id],
    );
  }
}

// saveGraph(List<Map<String, dynamic>> status,String name, int count) async {
//   List<String> TF = [];
//   String TFText = "";
//   List<Map<String, dynamic>> inputTF = status.map((e) =>
//   {
//     "isSelected": e["isSelected"],
//   }).toList();
//
//   inputTF.forEach((element) {
//     String isTF;
//     if (element["isSelected"] == true){
//       isTF = "T";
//     }
//     else {
//       isTF = "F";
//     }
//     TF.add(isTF);
//   });
//
//   for(int i = 0; i <= 168; i++ ) {
//     TFText +="${TF[i]}";
//   }
//   final graphs = await Graph.getGraph();
//   int id = 0;
//   if(graphs.length != 0){
//     id = graphs.last.id + 1;
//   }
//   Graph graph = Graph(id: id, text: TFText, name: name, count: count);
//   await Graph.insertGraph(graph);
// }
//
// updateGraph(List<Map<String, dynamic>> status,int graphId, int graphCount, String graphName) async {
//   List<String> TF = [];
//   String TFText = "";
//   List<Map<String, dynamic>> inputTF = status.map((e) =>
//   {
//     "isSelected": e["isSelected"],
//   }).toList();
//
//   inputTF.forEach((element) {
//     String isSelected;
//     if (element["isSelected"] == true){
//       isSelected = "T";
//     }
//     else {
//       isSelected = "F";
//     }
//     TF.add(isSelected);
//   });
//
//   for(int i = 0; i <= 168; i++ ) {
//     TFText +="${TF[i]}";
//   }
//
//   if(graphId == null){
//     print("TODO");
//   }
//   else{
//     await Graph.updateGraph(Graph(id: graphId, text: TFText, count: graphCount, name:graphName));
//   }
// }