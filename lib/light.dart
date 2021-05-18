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

lightButton(String name, function){
  return
    ElevatedButton(onPressed: () => function, child: Text(name));
}