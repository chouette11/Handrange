import 'package:flutter/cupertino.dart';
import 'package:handrange/datas/combination.dart';
import 'package:handrange/datas/sql.dart';

class EqCalculation extends ChangeNotifier {
  int num1_1 = 0;
  int num1_2 = 0;
  int num2_1 = 0;
  int num2_2 = 0;

  String mark1_1 = "";
  String mark1_2 = "";
  String mark2_1 = "";
  String mark2_2 = "";

  String card1_1 = "";
  String card1_2 = "";
  String card2_1 = "";
  String card2_2 = "";

  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  String graphName = "";
  onGet(int id,String name) async {
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
    graphName = name;
    notifyListeners();
  }
}