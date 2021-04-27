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
  double count = 0;

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
    isPocket = !isPocket;
    status.forEach((element) {
      if (element["hand"].length == 2) {
        element["isSelected"] = isPocket;
        isPocket ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onAhigh() {
    isAce = !isAce;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('A')) {
        element["isSelected"] = isAce;
        isAce ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onKhigh() {
    isKing = !isKing;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('K') || hand.endsWith('Ks') || hand.endsWith('Ko') ) {
        element["isSelected"] = isKing;
        isKing ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onQhigh() {
    isQueen = !isQueen;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('Q') || hand.endsWith('Qs') || hand.endsWith('Qo')) {
        element["isSelected"] = isQueen;
        isQueen ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  onJhigh() {
    isJack = !isJack;
    status.forEach((element) {
      String hand = element["hand"];
      if (hand.startsWith('J') || hand.endsWith('Js') || hand.endsWith('Jo')) {
        element["isSelected"] = isJack;
        isJack ? count = count + element["value"] : count = count - element["value"];
      }
    }
    );
    notifyListeners();
  }

  List <List> TFs = [];
  List <Map<String,int>> numbers = [];

  Creategraphs() async {
    final List<Graph> graphs = await Graph.getGraph();
    List <Map<String,int>> inputNumbers = [];
    List <List> inputTFs = [];
    int i, j,k;

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
    for(k = 0; k < graphs.length; k++){
      Map <String,int> numbers_map = {};
      numbers_map.addAll(
          <String,int>{
            "id": k
          }
      );
      inputNumbers.add(numbers_map);
      print(inputNumbers);
    }
    TFs = inputTFs;
    numbers = inputNumbers;
    notifyListeners();
  }

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

    Graph graph = Graph(text: TFText);
    await Graph.insertGraph(graph);
    notifyListeners();
  }

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

  onGet(int id) async {
    final graphs = await Graph.getGraph();
    int i;
    String TFText = graphs[id].text;
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

  onDelete(int id) async {
    await Graph.deleteGraph(id);
  }
}

