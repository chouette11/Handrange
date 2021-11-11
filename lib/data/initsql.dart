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
    db.insert(
      'initGraph',
      graph.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<InitGraph>> getInitGraph() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('initGraph');
    if(maps.length == 0){
      insertInitGraph(InitGraph(
          id: 0,
          text:"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "noName1",
          count: 0),
      );
      insertInitGraph(InitGraph(
          id: 1,
          text:"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "noName2",
          count: 0),
      );
      insertInitGraph(InitGraph(
          id: 2,
          text:"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "noName3",
          count: 0),
      );
      insertInitGraph(InitGraph(
          id: 3,
          text:"TTTTTTTTTTTTTTTTTTFFFFFFFFTTTTTFFFFFFFFTTFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "UTG",
          count: 234),
      );
      insertInitGraph(InitGraph(
          id: 4,
          text:"TTTTTTTTTTTTTTTTTTFFFFFFFFTTTTTFFFFFFFFTTTTTTFFFFFFFTFFFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
          name: "HJ",
          count: 250),
      );
      insertInitGraph(InitGraph(
          id: 5,
          text:"TTTTTTTTTTTTTTTTTTTTTFFFFFTTTTTTFFFFFFFTTTTTTFFFFFFFTTTTTTTFFFFFFTFFFFTTFFFFFFFFFFFFTTFFFFFFFFFFFFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFT",
          name: "CO",
          count: 342),
      );
      insertInitGraph(InitGraph(
          id: 6,
          text:"TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTFFFFTTTTTTTTFFFFFTTTTTTTFFFFFFTTTTTTTTFFFFFTFFFFFTTFFFFFTFFFFFFTTFFFFFFFFFFFFTTFFFTFFFFFFFFTTFFFFFFFFFFFFTFFFFFFFFFFFFFTFFFFFFFFFFFFFT",
          name: "BTN",
          count: 462),
      );
    }
    return List.generate(maps.length, (i) {
      return InitGraph(
        id: maps[i]['id'],
        text: maps[i]['text'],
        name: maps[i]['name'],
        count: maps[i]['count'],
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
