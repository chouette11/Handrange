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
  bool isButton = false;
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
      pocketHand(element, isPocket);
    });
    isPocket ? count += 78 : count -= 78;
    notifyListeners();
  }

  pocketHand(element,bool name){
    if (element["hand"].contains( RegExp(r"(.)\1") )) {
      if(element["isSelected"] == true && name == true){
        count -= element["value"];
      }
      if(element["isSelected"] == false && name == false){
        count += element["value"];
      }
      element["isSelected"] = name;
    }
  }

  onClear() {
    status.forEach((element) {
      element["isSelected"] = false;
    });
    count = 0;
    notifyListeners();
  }

  onUTG(){
    final List check = status.where(
            (element) =>
      (element["hand"].contains("A") && element["hand"].contains("s")) || ((element["hand"].contains("K") && element["hand"].contains("s")) && !element["hand"].contains("0"))
    ).toList();
    print(check);
    notifyListeners();
  }

  onHJ(){
    status.forEach((element) {
      onHand(0, "A","s", element);
      onHand(8, "K","s", element);
      onHand(8, "Q","s", element);
      onHand(8, "J","s", element);
      onHand(8, "T","s", element);
      onHand(9, "A","o", element);
      onHand(9, "K","o", element);
      onHand(10, "Q","o", element);
      onHand(10, "J","o", element);
    });
    notifyListeners();
  }

  onCO(){
    status.forEach((element) {
      onHand(0, "A","s", element);
      onHand(5, "K","s", element);
      onHand(7, "Q","s", element);
      onHand(8, "J","s", element);
      onHand(7, "T","s", element);
      onHand(7, "9","s", element);
      onHand(8, "A","o", element);
      onHand(9, "K","o", element);
      onHand(9, "Q","o", element);
      onHand(9, "J","o", element);
      onConnect(4, "s", element);
    });
    notifyListeners();
  }

  onBTN(){
    status.forEach((element) {
      onHand(1, "A","s", element);
      onHand(1, "K","s", element);
      onHand(4, "Q","s", element);

    });
    notifyListeners();
  }

  bool onHand(int exNum, String mainNum, String isSuit, element) {
    int i;
    for (i = 1; i <= exNum; i++) {
       return
      (element["hand"].contains("$mainNum$isSuit") && !element["hand"].contains("$i"));
    }
  }
  onConnect(int minNum, String isSuit, element){
    int i;
    for(i = 9; i > minNum; i--){
      if(element["hand"].contains("${i}${i - 1}${isSuit}")){
        element["isSelected"] = true;
      }
    }
  }

//sqlからgraphのリストを受け取ってタップ時に読み込み
  String graphName = "";
  int graphId;
  int graphCount;
  onGet(int id, String name, int inputCount) async {
    final graphs = await Graph.getGraph();
    String TFText = graphs[id].text;
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
    graphId = id;
    graphName = name;
    graphCount = inputCount;
    count = inputCount;
    notifyListeners();
  }
}

lightButton(String name, function){
  return
    ElevatedButton(onPressed: () => function, child: Text(name));
}
