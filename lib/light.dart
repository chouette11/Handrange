import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/sql.dart';

class Light extends ChangeNotifier {
  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  bool isPocket = false;
  Map highs = {
    'A': false,
    'K': false,
    'Q': false,
    'J': false,
  };
  bool isAll = false;
  int count = 0;


  onHighs(String num){
    highs[num] = !highs[num];
    status.forEach((element) {
      if (element["hand"].contains(num)) {
        if (element["isSelected"] == true && highs[num] == true) {
          count -= element["value"];
        }
        if (element["isSelected"] == false && highs[num] == false) {
          count += element["value"];
        }
        element["isSelected"] = highs[num];
      }
    }
    );
    highs[num] ? count = count + 198 : count = count - 198;
    notifyListeners();
  }

  onTapped(String hand) {
    final tappedBox = status.firstWhere((e) => e["hand"] == hand);
    tappedBox["isSelected"] = !tappedBox["isSelected"];
    tappedBox["isSelected"] ? count += tappedBox["value"] : count -= tappedBox["value"];
    notifyListeners();
  }

  onPocket() {
    isPocket= !isPocket;
    status.forEach((element) {
      if (element["hand"].contains( RegExp(r"(.)\1") )) {
        if(element["isSelected"] == true && isPocket == true){
          count -= element["value"];
        }
        if(element["isSelected"] == false && isPocket == false){
          count += element["value"];
        }
        element["isSelected"] = isPocket;
      }
    }
    );
    isPocket ? count += 78 : count -= 78;
    notifyListeners();
  }

  onAll() {
    isAll = !isAll;
    status.forEach((element) {
      element["isSelected"] = isAll;
    }
    );
    isAll ? count = 1326 : count = 0;
    notifyListeners();
  }


  List <List> TFs = [];
  List <Map<String,dynamic>> numbers = [];
//sqlからデータを受け取りsavepageの作成
  createGraphs() async {
    final List<Graph> graphs = await Graph.getGraph();
    List <Map<String,dynamic>> inputNumbers = [];
    List <List> inputTFs = [];
    int i, j,k;
    print(graphs);
    print(graphs.length);
    for (j = 0; j < graphs.length ; j++) {
      String TFText = graphs[j].text;
      List<Map<String, dynamic>> TF = CONBI.map((e) => {
        "hand": e["hand"],
        "value": e["value"],
      }).toList();

      for (i = 0; i <= 168; i++) {
        String isTF = TFText[i];
        if (isTF == "T") {
          TF[i].addAll(
              <String, bool>{
                "isSelected": true,
              }
          );
        }
        else if (isTF == "F") {
          TF[i].addAll(
              <String, bool>{
                "isSelected": false,
              }
          );
        }
      }
      inputTFs.add(TF);
    }
    for(i = 0; i < graphs.length; i++){
      int id = graphs[i].id;
      String graphName = graphs[i].name;
      int num = graphs[i].count;
      Map <String,dynamic> numbers_map = {};
      numbers_map.addAll(
          <String,dynamic>{
            "id": id,
            "num":i,
            "name":graphName,
            "count": num
          }
      );
      inputNumbers.add(numbers_map);
    }
    TFs = inputTFs;
    numbers = inputNumbers;
    notifyListeners();
  }
//mainのgraphをsqlに送る
  String name = "";
  onSave() async {
    List<String> TF = new List<String>();
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
      id = graphs.last.id + 1;;
    }
    Graph graph = Graph(id: id, text: TFText, name: name, count: count);
    await Graph.insertGraph(graph);
    notifyListeners();
  }
//まだ
  onUpdate() async {
    List<String> TF = new List<String>();
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

    Graph graph = Graph(id: 1, text: TFText);
    await Graph.updateGraph(graph);
  }
//sqlからgraphのリストを受け取ってタップ時に読み込み
  String graphName = "";
  onGet(int id, String name) async {
    final graphs = await Graph.getGraph();
    String TFText = graphs[id].text;
    count = graphs[id].count;
    int i;
    for(i = 0; i <= 168; i++){
      String isTF = TFText[i];
      if(isTF == "T"){
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,bool>{
              "isSelected": true,
            }
        );
      }
      else if (isTF == "F"){
        status[i].removeWhere((key, value) => value == false || value == true);
        status[i].addAll(
            <String,dynamic>{
              "isSelected": false,
            }
        );
      }
    }
    graphName = name;
    notifyListeners();
  }

}

