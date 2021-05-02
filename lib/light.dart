import 'dart:convert';

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
  bool isAce = false;
  bool isKing = false;
  bool isQueen = false;
  bool isJack = false;
  bool isAll = false;
  int count = 0;

  onTapped(String hand) {
    status.forEach((element) {
      if (element["hand"] == hand) {
        element["isSelected"] = !element["isSelected"];
        element["isSelected"] ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onPocket() {
    isPocket= !isPocket;
    status.forEach((element) {
      String hand = element["hand"];
      if (element["hand"].length == 2) {
        if(element["isSelected"] == true && isPocket == true){
          count = count - element["value"];
        }
        if(element["isSelected"] == false && isPocket == false){
          count = count + element["value"];
        }
        element["isSelected"] = isPocket;
      }
    }
    );
    isPocket ? count = count + 198 : count = count - 198;
    notifyListeners();
  }

  onAhigh() {
    isAce = !isAce;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('A') || hand.endsWith('As') || hand.endsWith('Ao')) {
        if(element["isSelected"] == true && isAce == true){
          count = count - element["value"];
        }
        if(element["isSelected"] == false && isAce == false){
          count = count + element["value"];
        }
        element["isSelected"] = isAce;
      }
    }
    );
    isAce ? count = count + 198 : count = count - 198;
    notifyListeners();
  }

  onKhigh() {
    isKing = !isKing;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('K') || hand.endsWith('Ks') || hand.endsWith('Ko')) {
        if(element["isSelected"] == true && isKing == true){
          count = count - element["value"];
        }
        if(element["isSelected"] == false && isKing == false){
          count = count + element["value"];
        }
        element["isSelected"] = isKing;
      }
    }
    );
    isKing ? count = count + 198 : count = count - 198;
    notifyListeners();
  }

  onQhigh() {
    isQueen = !isQueen;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('Q') || hand.endsWith('Qs') || hand.endsWith('Qo')) {
        if(element["isSelected"] == true && isQueen == true){
          count = count - element["value"];
        }
        if(element["isSelected"] == false && isQueen == false){
          count = count + element["value"];
        }
        element["isSelected"] = isQueen;
      }
    }
    );
    isQueen ? count = count + 198 : count = count - 198;
    notifyListeners();
  }

  onJhigh() {
    isJack = !isJack;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('J') || hand.endsWith('Js') || hand.endsWith('Jo')) {
        if(element["isSelected"] == true && isJack == true){
          count = count - element["value"];
        }
        if(element["isSelected"] == false && isJack == false){
          count = count + element["value"];
        }
        element["isSelected"] = isJack;
      }
    }
    );
    isJack ? count = count + 198 : count = count - 198;
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

    for (j = 0; j < graphs.length ; j++) {
      String TFText = graphs[j].text;
      int id = graphs[j].id;
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
      print(id);
    }
    for(k = 0; k < graphs.length; k++){
      String graphName = graphs[k].name;
      int num = graphs[k].count;
      Map <String,dynamic> numbers_map = {};
      numbers_map.addAll(
          <String,dynamic>{
            "id": k,
            "name":graphName,
            "count": num
          }
      );
      inputNumbers.add(numbers_map);
      print(inputNumbers);
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
    int id = graphs.length;
    Graph graph = Graph(id: id, text: TFText, name: name, count: count);
    print(graph);
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
    print(graph);
  }
//sqlからgraphのリストを受け取ってタップ時に読み込み
  onGet(int id) async {
    final graphs = await Graph.getGraph();
    String TFText = graphs[id].text;
    count = graphs[id].count;
    print(count);
    print(graphs[id].count);
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
    notifyListeners();
  }
//intを受け取ってsqlの変更

}

