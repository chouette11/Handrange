import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:handrange/combination.dart';

class Light extends ChangeNotifier {
  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  bool isPocketed = false;
  double count = 0;


  onTapped(String hand) {
    status.forEach((element) {
      if (element["hand"] == hand) {
        element["isSelected"] = !element["isSelected"];
        count = count + element["value"];
    }
    }
    );
    notifyListeners();
    }



  onPocket() {
    isPocketed = !isPocketed;
    status.forEach((element) {
      if (element["hand"].length == 2) {
        element["isSelected"] = isPocketed;
        count = count + element["value"];
      }
    });
    notifyListeners();
  }
}