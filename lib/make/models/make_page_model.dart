import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handrange/data/combination.dart';
import 'package:handrange/data/initsql.dart';
import 'package:handrange/data/sql.dart';

class MakePageModel extends ChangeNotifier {
  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  bool isPocket = false;
  bool isButton = false;
  Map highs = {
    'A': false,
    'K': false,
    'Q': false,
    'J': false,
  };
  bool isAll = false;
  int count = 0;

  onTapped(String hand, List<Map<String, dynamic>> range) {
    final tappedBox = range.firstWhere((e) => e["hand"] == hand);
    int value = tappedBox["value"];

    tappedBox["isSelected"] = !tappedBox["isSelected"];
    tappedBox["isSelected"] ? count += value : count -= value;
    notifyListeners();
  }

  onPocket() {
    isPocket= !isPocket;
    status.forEach((element) {
      int value = element["value"];

      if (element["hand"].contains( RegExp(r"(.)\1") )) {
        if (element["isSelected"] == true && isPocket == true) {
          count -= value;
        }
        if (element["isSelected"] == false && isPocket == false) {
          count += value;
        }
        element["isSelected"] = isPocket;
      }
    });
    isPocket ? count += 78 : count -= 78;
    notifyListeners();
  }

  onClear() {
    status.forEach((element) {
      element["isSelected"] = false;
    });
    count = 0;
    notifyListeners();
  }

  Map isNames = {
    0: false,
    1: false,
    2: false,
  };
  List<String> initGraphName = ["1","2","3"];
  changeName(String name, int id) {
    isNames[id] = true;
    initGraphName[id] = name;
  }

  getInitGraph(int id) async {
    final  initGraphs = await InitGraph.getInitGraph();
    String tfText = initGraphs[id].text;
    count = initGraphs[id].count;

    int i;
    for (i = 0; i <= 168; i++) {
      String isTF = tfText[i];
      if (isTF == "T") {
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,bool>{
              "isSelected": true,
            }
        );
      }
      else if (isTF == "F") {
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,dynamic>{
              "isSelected": false,
            }
        );
      }
    }
    notifyListeners();
  }

//sqlからgraphのリストを受け取ってタップ時に読み込み
  String rangeName = "";
  late int rangeId;
  late int rangeCount;
  onGet(int id, String name, int inputCount) async {
    final graphs = await Graph.getGraph();
    String tfText = graphs[id].text;

    int i;
    for (i = 0; i <= 168; i++) {
      String isTF = tfText[i];

      if (isTF == "T") {
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,bool>{
              "isSelected": true,
            }
        );
      }
      else if (isTF == "F") {
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,dynamic>{
              "isSelected": false,
            }
        );
      }
    }
    rangeId = graphs[id].id;
    rangeName = name;
    rangeCount = inputCount;
    count = inputCount;
    notifyListeners();
  }
}
