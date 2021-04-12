import 'package:handrange/combination.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class SqlText {
  static void CreateText() {
    List<String> hands = new List<String>();
    String inputText = "";
    int i = 0;

    List<Map<String, dynamic>> inputhands = CONBI.map((e) =>
    {
      "hand": e["hand"],
    }).toList();

    inputhands.forEach((element) {
      String hand = element["hand"];
      hands.add(hand);
    });

    for(int i = 0; i <= 168; i++ ) {
      inputText +=" ${hands[i]} INTEGER,";
      //print(inputText);
    }
    print(inputText);
  }
}
class Graph {
  final List<Map<String, dynamic>> status;

  Graph({this.status});

  Map<String, dynamic> toMap() {
    Map<String, bool> s = {};
    status.forEach((element) {
      s[element["hand"]] = element["isSelected"]; // s["AA"] = false;
    });
    return s;
  }

  @override
  String toString() {
    return 'Graph{status: $status}';
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'graph_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE graph(id INTEGER PRIMARY KEY AUTOINCREMENT)",
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
    final List<Map<String, dynamic>> maps = await db.query('memo');
    return List.generate(maps.length, (i) {
      return Graph(
        status: maps[i]['status'],
      );
    });
  }

  static Future<void> updateGraph(Graph graph) async {
    final db = await database;
    await db.update(
      'graph',
      graph.toMap(),
      where: "id = ?",
      whereArgs: [graph.status],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> deleteGraph(int id) async {
    final db = await database;
    await db.delete(
      'memo',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
