import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/combination.dart';
import 'package:flutter/material.dart';
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
  String card1;
  String card2;
  String card3;
  String card4;
  String card5;
  int royal = 0;
  int straightFlush = 0;
  int fourCards = 0;
  int fullHouse = 0;
  int flush = 0;
  int straight = 0;
  int threeCards = 0;
  int twoPair = 0;
  int onePair = 0;
  int sum = 1;

  graphJudge() {
    int inputSum = 0;
    int inputRoyalStraightFlash= 0;
    int inputStraightFlush = 0;
    int inputFourCards = 0;
    int inputFullHouse = 0;
    int inputFlush = 0;
    int inputStraight = 0;
    int inputThreeCards = 0;
    int inputTwoPair = 0;
    int inputOnePair = 0;

    handJudge(String isSuit) {
      List<int> numbers = [];
      numbers.add(num1);
      numbers.add(num2);
      numbers.add(num3);
      if(num4 != null){
        numbers.add(num4);
      }
      if(num5 != null){
        numbers.add(num5);
      }
      numbers.add(num6);
      numbers.add(num7);
      numbers.sort();
      List<String> marks = [];
      marks.add(mark1);
      marks.add(mark2);
      marks.add(mark3);
      if(mark4 != null) {
        marks.add(mark4);
      }
      if(mark5 != null){
        marks.add(mark5);
      }
      List<String> cards = [];
      cards.add(card1);
      cards.add(card2);
      cards.add(card3);
      if(card4 != null){
        cards.add(card4);
      }
      if(card5 != null){
        cards.add(card5);
      }
      List <String> mark = ["s", "c", "h", "d"];
      List <String> selectedMark = ["ss","cc","hh","dd"];
      int i, j, l, m;
      int max = numbers.length;

      onCalculate(){
        for(i = 0; i <= 3; i++){
          if(cards.contains("13${mark[i]}") && cards.contains("12${mark[i]}") && cards.contains("11${mark[i]}") && cards.contains("10${mark[i]}") && cards.contains("1${mark[i]}")){
            print("Royal");
            inputRoyalStraightFlash++;
          }
        }
        for(i = 0; i <= max - 5; i++){
          for(j = 0; j <= 3; j++){
            if (cards.contains("${i}${mark[j]}") && cards.contains("${i + 1}${mark[j]}") &&
                cards.contains("${i + 2}${mark[j]}") && cards.contains("${i + 3}${mark[j]}") &&
                cards.contains("${i + 4}${mark[j]}")) {
              print("StraightFlush");
              inputStraightFlush++;
              break;
            }
          }
        }
        for (i = 0; i <= max - 4; i++) {
          if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2] &&
              numbers[i] == numbers[i + 3])) {
            print("FourCards");
            inputFourCards++;
            break;
          }
        }
        for (i = 0; i <= 2; i++) {
          for (j = i + 3; j <= 5; j++) {
            if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) &&
                numbers[j] == numbers[j + 1]) {
              print("FullHouse");
              inputFullHouse++;
              break;
            }
          }
          break;
        }
        for (i = 2; i <= 4; i++) {
          for (j = i - 2; j >= 0; j--) {
            if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) &&
                numbers[j] == numbers[j + 1]) {
              print("FullHouse");
              inputFullHouse++;
              break;
            }
          }
          break;
        }
        for (i = 0; i <= max - 5; i++) {
          for(j = 0; j <= 3; j++){
            if (marks[i].contains(mark[j]) && marks[i + 1].contains(mark[j]) && marks[i + 2].contains(mark[j]) &&  marks[i + 3].contains(mark[j]) && marks[i + 4].contains(mark[j])) {
              print("flush");
              inputFlush++;
              break;
            }
          }
        }
        for (i = 1; i <= 8; i++) {
          if (numbers.contains(i) && numbers.contains(i + 1) &&
              numbers.contains(i + 2) && numbers.contains(i + 3) &&
              numbers.contains(i + 4)) {
            print("Straight");
            inputStraight++;
            break;
          }
        }
        if(numbers.contains(1) && numbers.contains(10) &&
            numbers.contains(11) && numbers.contains(12) &&
            numbers.contains(13)){
          print("Straight");
          inputStraight++;
        }
        for (i = 0; i <= max - 3; i++) {
          if (numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) {
            print("ThreeCards");
            inputThreeCards++;
            break;
          }
        }
        for (i = 0; i <= max - 4; i++) {
          for (j = i + 2; j <= max - 2; j++) {
            if (numbers[i] == numbers[i + 1] && numbers[j] == numbers[j + 1]) {
              print("TwoPair");
              inputTwoPair++;
              break;
            }
          }
        }
        for (i = 0; i <= max - 2; i++) {
          if (numbers[i] == numbers[i + 1]) {
            print("OnePair");
            inputOnePair++;
            break;
          }
        }
      }
      //end onCalculate
      if (isSuit == "s") {
        for(l = 0; l <= 3; l++){
          String mark6 = mark[l];
          String mark6_2 = selectedMark[l];
          String card1 = "${num6}${mark6}";
          String card2 = "${num7}${mark6}";
          marks.add(mark6_2);
          marks.add(mark6_2);
          marks.sort((a, b) => a.compareTo(b));
          if((cards.every((hand) => hand != card1)) && (cards.every((hand) => hand != card2))){
            onCalculate();
            inputSum++;
          }
          marks.remove(mark6);marks.remove(mark6);
        }
      }
      else if(isSuit =="o"){
        for(m = 0; m <= 2; m++){
          for(l = m + 1; l <= 3; l++){
            String mark6 = mark[l];
            String mark7 = mark[m];
            String mark6_2 = selectedMark[l];
            String mark7_2 = selectedMark[m];
            String card1 = "${num6}${mark6}";
            String card2 = "${num7}${mark7}";
            marks.add(mark6_2);
            marks.add(mark7_2);
            marks.sort((a, b) => a.compareTo(b));
            if((cards.every((hand) => hand != card1)) && (cards.every((hand) => hand != card2))){
              onCalculate();
              inputSum++;
              onCalculate();
              inputSum++;
            }
            marks.remove(mark6);
            marks.remove(mark7);
          }
        }
      }
      else if(isSuit == "p"){
        for(m = 0; m <= 2; m++){
          for(l = m + 1; l <= 3; l++) {
            String mark6 = mark[l];
            String mark7 = mark[m];
            String mark6_2 = selectedMark[l];
            String mark7_2 = selectedMark[m];
            String card1 = "${num6}${mark6}";
            String card2 = "${num7}${mark7}";
            marks.add(mark6_2);
            marks.add(mark7_2);
            marks.sort((a, b) => a.compareTo(b));
            if((cards.every((hand) => hand != card1)) && (cards.every((hand) => hand != card2))){
              onCalculate();
              inputSum++;
            }
            marks.remove(mark6);
            marks.remove(mark7);
          }
        }
      }
    }
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
    royal = inputRoyalStraightFlash;
    straightFlush = inputStraightFlush;
    fourCards = inputFourCards;
    fullHouse = inputFullHouse;
    flush = inputFlush;
    straight = inputStraight;
    threeCards = inputThreeCards;
    twoPair = inputTwoPair;
    onePair = inputOnePair;
    sum = inputSum;
    notifyListeners();
  }

  List<int> comboList;
  createList(){
    List<int> inputComboList = [];
    inputComboList.add(royal);
    inputComboList.add(straightFlush);
    inputComboList.add(fourCards);
    inputComboList.add(fullHouse);
    inputComboList.add(flush);
    inputComboList.add(straight);
    inputComboList.add(threeCards);
    inputComboList.add(twoPair);
    inputComboList.add(onePair);
    inputComboList.add(sum);
    comboList = inputComboList;
    notifyListeners();
  }

  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

  String graphName = "";
  onGet(int id,String name) async {
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
    graphName = name;
    notifyListeners();
  }
  List <List> TFs = [];
  List <Map<String,dynamic>> numbers = [];
//sqlからデータを受け取りsavepageの作成
  createGraphs() async {
    final List<Graph> graphs = await Graph.getGraph();
    List <Map<String,dynamic>> inputNumbers = [];
    List <List> inputTFs = [];
    int i, j;
    print(graphs);
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
}

