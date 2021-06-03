import 'package:flutter/cupertino.dart';
import 'package:handrange/datas/sql.dart';

class FixRange extends ChangeNotifier {
  renameRange(int id, String text, String name, int count) async {
    await Graph.updateGraph(Graph(id: id, text: text, name: name, count: count));
    notifyListeners();
  }

  deleteRange(int id) async {
    await Graph.deleteGraph(id);
  }
}