import 'package:handrange/combination.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class Graph {
  final int id;
  final String text;

  Graph({this.id, this.text});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
    };
  }
  @override
  String toString() {
    return 'Graph{id: $id, text: $text}';
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'graph_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE graph(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT)"
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
