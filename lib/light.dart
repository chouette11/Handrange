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

  onSave() async {
    List<String> judge = new List<String>();
    String inputText = "";
    List<Map<String, dynamic>> inputjudge = status.map((e) =>
    {
      "isSelected": e["isSelected"],
    }).toList();

    inputjudge.forEach((element) {
      String isSelected;
      if (element["isSelected"] == true){
        isSelected = "T";
      }
      else {
        isSelected = "F";
      }
      judge.add(isSelected);
    });

    for(int i = 0; i <= 168; i++ ) {
      inputText +="${judge[i]}";
    }

    Graph graph = Graph(text: inputText);
    await Graph.insertGraph(graph);
    notifyListeners();
  }

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
}

