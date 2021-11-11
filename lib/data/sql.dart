import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class Graph {
  final int id;
  final String text;
  final String name;
  final int count;

  Graph({required this.id, required this.text, required this.name, required this.count});
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
    return 'Graph{id: $id, text: $text, name: $name, count: $count}';
  }

  static Future<Database> get database async {
    String? path = await getDatabasesPath();
    final Future<Database> _database = openDatabase(
      join(path!, 'graph_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE graph(id INTEGER PRIMARY KEY, text TEXT, name TEXT, count INTEGER)"
        );
      },
      version: 1,
    );
    return _database;
  }

  static Future<void> insertGraph(Graph graph) async {
    final Database db = await database;
    await db.insert(
      'graph',
      graph.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Graph>> getGraph() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('graph');
    return List.generate(maps.length, (i) {
      return Graph(
        id: maps[i]['id'],
        text: maps[i]['text'],
        name: maps[i]['name'],
        count: maps[i]['count']
      );
    });
  }

  static Future<void> updateGraph(Graph graph) async {
    final db = await database;
    await db.update(
      'graph',
      graph.toMap(),
      where: "id = ?",
      whereArgs: [graph.id],
    );
  }

  static Future<void> deleteGraph(int id) async {
    final db = await database;
    await db.delete(
      'graph',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

saveGraph(List<Map<String, dynamic>> status,String name, int count) async {
  List<String> TF = [];
  String TFText = "";
  List<Map<String, dynamic>> inputTF = status.map((e) =>
  {
    "isSelected": e["isSelected"],
  }).toList();

  inputTF.forEach((element) {
    String isTF;
    if (element["isSelected"] == true){
      isTF = "T";
    }
    else {
      isTF = "F";
    }
    TF.add(isTF);
  });

  for(int i = 0; i <= 168; i++ ) {
    TFText +="${TF[i]}";
  }
  final graphs = await Graph.getGraph();
  int id = 0;
  if(graphs.length != 0){
    id = graphs.last.id + 1;
  }
  Graph graph = Graph(id: id, text: TFText, name: name, count: count);
  await Graph.insertGraph(graph);
}

updateGraph(List<Map<String, dynamic>> status,int graphId, int graphCount, String graphName) async {
  List<String> TF = [];
  String TFText = "";
  List<Map<String, dynamic>> inputTF = status.map((e) =>
  {
    "isSelected": e["isSelected"],
  }).toList();

  inputTF.forEach((element) {
    String isSelected;
    if (element["isSelected"] == true){
      isSelected = "T";
    }
    else {
      isSelected = "F";
    }
    TF.add(isSelected);
  });

  for(int i = 0; i <= 168; i++ ) {
    TFText +="${TF[i]}";
  }

  if(graphId == null){
    print("TODO");
  }
  else{
    final graphs = await Graph.getGraph();
    print(graphs);
    print(Graph(id: graphId, text: TFText, count: graphCount, name:graphName));
    await Graph.updateGraph(Graph(id: graphId, text: TFText, count: graphCount, name:graphName));
  }
}