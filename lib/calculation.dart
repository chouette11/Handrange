import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/save.dart';
import 'package:handrange/combination.dart';
import 'package:flutter/material.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/sql.dart';

class Calculation extends ChangeNotifier {
  int num1;
  int num2;
  int num3;
  int num4;
  int num5;
  int num6;
  int num7;
  String mark1;
  String mark2;
  String mark3;
  String mark4;
  String mark5;

  graphJudge() {
    status.forEach((element) {
      if (element["isSelected"] == true) {
        switch (element["hand"][0]) {
          case 'A':
            num6 = 1;
            break;
          case 'K':
            num6 = 13;
            break;
          case 'Q':
            num6 = 12;
            break;
          case 'J':
            num6 = 11;
            break;
          case 'T':
            num6 = 10;
            break;
          case '9':
            num6 = 9;
            break;
          case '8':
            num6 = 8;
            break;
          case '7':
            num6 = 7;
            break;
          case '6':
            num6 = 6;
            break;
          case '5':
            num6 = 5;
            break;
          case '4':
            num6 = 4;
            break;
          case '3':
            num6 = 3;
            break;
          case '2':
            num6 = 2;
            break;
        }
        switch (element["hand"][1]) {
          case 'A':
            num7 = 1;
            break;
          case 'K':
            num7 = 13;
            break;
          case 'Q':
            num7 = 12;
            break;
          case 'J':
            num7 = 11;
            break;
          case 'T':
            num7 = 10;
            break;
          case '9':
            num7 = 9;
            break;
          case '8':
            num7 = 8;
            break;
          case '7':
            num7 = 7;
            break;
          case '6':
            num7 = 6;
            break;
          case '5':
            num7 = 5;
            break;
          case '4':
            num7 = 4;
            break;
          case '3':
            num7 = 3;
            break;
          case '2':
            num7 = 2;
            break;
        }
        String hand = element["hand"];
        if (hand.endsWith('s')) {
          handJudge("s");
        }
        else if (hand.endsWith('o')) {
          handJudge('o');
        }
        else {
          handJudge('p');
        }
      }
    });
  }

  handJudge(String isSuit) {
    List<int> numbers = [];
    numbers.add(num1);
    numbers.add(num2);
    numbers.add(num3);
    numbers.add(num4);
    numbers.add(num5);
    numbers.add(num6);
    numbers.add(num7);
    numbers.sort();
    print(numbers);
    List<String> marks = [];
    marks.add(mark1);
    marks.add(mark2);
    marks.add(mark3);
    marks.add(mark4);
    marks.add(mark5);
    marks.sort();
    print(marks);
    List<String> hands = [];
    hands.add("${num1.toString()}${mark1}");
    hands.add("${num2.toString()}${mark2}");
    hands.add("${num3.toString()}${mark3}");
    hands.add("${num4.toString()}${mark4}");
    hands.add("${num5.toString()}${mark5}");
    print(hands);
    List <String> mark = ["s", "c", "h", "d"];
    int i, j, k, l, m;
    onCalculate(){
      for (i = 0; i <= 2; i++) {
        if (marks[i] == marks[i + 1] && marks[i] == marks[i + 2] && marks[i] == marks[i + 3] && marks[i] == marks[i + 4]) {
          if (numbers.contains(13) && numbers.contains(12) &&
              numbers.contains(11) && numbers.contains(10) &&
              numbers.contains(1)) {
            print("RoyalStraightFlush");
          }
          for (i = 1; i <= 8; i++) {
            if (numbers.contains(i) && numbers.contains(i + 1) &&
                numbers.contains(i + 2) && numbers.contains(i + 3) &&
                numbers.contains(i + 4)) {
              print("StraightFlush");
            }
          }
          print("flush");
        }
      }
      for (i = 0; i <= 3; i++) {
        if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2] &&
            numbers[i] == numbers[i + 3])) {
          print("FourCards");
        }
      }
      for (i = 0; i <= 2; i++) {
        for (j = i + 3; j <= 5; j++) {
          if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) &&
              numbers[j] == numbers[j + 1]) {
            print("FullHouse");
          }
        }
      }
      for (i = 2; i <= 4; i++) {
        for (j = i - 2; j >= 0; j--) {
          if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) &&
              numbers[j] == numbers[j + 1]) {
            print("FullHouse");
          }
        }
      }
      for (i = 1; i <= 8; i++) {
        if (numbers.contains(i) && numbers.contains(i + 1) &&
            numbers.contains(i + 2) && numbers.contains(i + 3) &&
            numbers.contains(i + 4)) {
          print("Straight");
        }
      }
      for (i = 0; i <= 4; i++) {
        if (numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) {
          print("ThreeCards");
        }
      }
      for (i = 0; i <= 3; i++) {
        for (j = i + 2; j <= 4; j++) {
          if (numbers[i] == numbers[i + 1] && numbers[j] == numbers[j + 1]) {
            print("TwoPair");
          }
        }
      }
      for (i = 0; i <= 5; i++) {
        if (numbers[i] == numbers[i + 1]) {
          print("OnePair");
        }
      }
    }

    if (isSuit == "s") {
      for(l = 0; l <= 3; l++){
        String mark6 = mark[l];
        String card1 = "${num6}${mark6}";
        String card2 = "${num7}${mark6}";
        marks.add(mark6);
        marks.add(mark6);
        if((hands.every((hand) => hand != card1)) && (hands.every((hand) => hand != card2)) ){
          onCalculate();
        }
      }
    }
    else if(isSuit =="o"){
      for(m = 0; m <= 2; m++){
        for(l = m + 1; l <= 3; l++){
          String mark6 = mark[l];
          String mark7 = mark[m];
          String card1 = "${num6}${mark6}";
          String card2 = "${num7}${mark7}";
          marks.add(mark6);
          marks.add(mark7);
          if((hands.every((hand) => hand != card1)) && (hands.every((hand) => hand != card2))){
            onCalculate();
          }
          mark6 = mark[l];
          mark7 = mark[m];
          card1 = "${num6}${mark6}";
          card2 = "${num7}${mark7}";
          marks.add(mark6);
          marks.add(mark7);
          if((hands.every((hand) => hand != card1)) && (hands.every((hand) => hand != card2))){
            onCalculate();
          }
        }
      }
    }
    else if(isSuit == "p"){
      for(m = 0; m <= 2; m++){
        for(l = m + 1; l <= 3; l++) {
          String mark6 = mark[l];
          String mark7 = mark[m];
          String card1 = "${num6}${mark6}";
          String card2 = "${num7}${mark7}";
          marks.add(mark6);
          marks.add(mark7);
          if((hands.every((hand) => hand != card1)) && (hands.every((hand) => hand != card2))){
            onCalculate();
          }
        }
      }
    }
  }

  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  String graphName = "";
  onGet(int id,) async {
    final graphs = await Graph.getGraph();
    String TFText = graphs[id].text;
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

}
