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

  int num1 = 0;
  int num2 = 0;
  int num3 = 0;
  int num4 = 0;
  int num5 = 0;

  String mark1 = "";
  String mark2 = "";
  String mark3 = "";
  String mark4 = "";
  String mark5 = "";

  String card1 = "";
  String card2 = "";
  String card3 = "";
  String card4 = "";
  String card5 = "";

  int royal = 0;
  int straightFlush = 0;
  int fourCards = 0;
  int fullHouse = 0;
  int flush = 0;
  int straight = 0;
  int threeCards = 0;
  int twoPair = 0;
  int onePair = 0;
  int sum = 0;

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

      if(num4 != 0){
        numbers.add(num4);
      }

      if(num5 != 0){
        numbers.add(num5);
      }

      List<String> marks = [];
      marks.add(mark1);
      marks.add(mark2);
      marks.add(mark3);

      if(mark4 != "") {
        marks.add(mark4);
      }

      if(mark5 != ""){
        marks.add(mark5);
      }

      List<String> cards = [];
      cards.add(card1);
      cards.add(card2);
      cards.add(card3);

      if(card4 != ""){
        cards.add(card4);
      }

      if(card5 != ""){
        cards.add(card5);
      }

      List <String> mark = ["s", "c", "h", "d"];
      List <String> selectedMark = ["ss","cc","hh","dd"];
      int i, j, l, m;
      int max = numbers.length;

      onCalculate() {
        for(i = 0; i <= 3; i++){
          String doubleMark = "${mark[i]}${mark[i]}";
          if((cards.contains("13${mark[i]}") || cards.contains("13$doubleMark")) && (cards.contains("12${mark[i]}") || cards.contains("12$doubleMark")) && (cards.contains("11${mark[i]}") || cards.contains("11$doubleMark")) && (cards.contains("10${mark[i]}") || cards.contains("10$doubleMark")) && (cards.contains("1${mark[i]}") || cards.contains("1$doubleMark"))){
            print("Royal");
            inputRoyalStraightFlash++;
          }
        }
        for(i = 0; i <= max - 5; i++){
          for(j = 0; j <= 3; j++){
            String doubleMark = "${mark[i]}${mark[i]}";
            if ((cards.contains("$i${mark[j]}") || cards.contains("$i$doubleMark")) && (cards.contains("${i + 1}${mark[j]}") || cards.contains("${i + 1}$doubleMark")) &&
                (cards.contains("${i + 2}${mark[j]}") || cards.contains("${i + 2}$doubleMark")) && (cards.contains("${i + 3}${mark[j]}") || cards.contains("${i + 3}$doubleMark")) &&
                (cards.contains("${i + 4}${mark[j]}") || cards.contains("${i + 4}$doubleMark"))) {
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
        for (i = 0; i <= max - 5; i++) {
          for (j = i + 3; j <= max - 2; j++) {
            if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) &&
                numbers[j] == numbers[j + 1]) {
              print("FullHouse");
              inputFullHouse++;
              break;
            }
          }
          break;
        }
        for (i = 2; i <= max - 3; i++) {
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
      int num6 = num1_1;
      int num7 = num1_2;
      numbers.add(num6);
      numbers.add(num7);
      numbers.sort((a, b) => a.compareTo(b));

      String mark6 = mark1_1;
      String mark7 = mark1_2;
      marks.add(mark6);
      marks.add(mark7);
      marks.sort((a, b) => a.compareTo(b));

      String card6 = "$num6$mark6";
      String card7 = "$num7$mark7";

      if((cards.every((hand) => hand != card1)) && (cards.every((hand) => hand != card2))){
        onCalculate();
        inputSum++;
      }

    }
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

  List<Map<String, dynamic>> status1 = CONBI.map((e) => {
    "hand": e["hand"],
    "isSelected": false,
  }).toList();

  List<Map<String, dynamic>> status2 = CONBI.map((e) => {
    "hand": e["hand"],
    "isSelected": false,
  }).toList();

  String graphName1 = "";
  onGet1(int id,String name) async {
    final graphs = await Graph.getGraph();
    String tfText = graphs[id].text;
    int i;
    for (i = 0; i <= 168; i++) {
      String isTF = tfText[i];
      if (isTF == "T") {
        status1[i].removeWhere((key, value) => value == false || value == true);
        status1[i].addAll(
            <String,bool>{
              "isSelected": true,
            }
        );
      }
      else if (isTF == "F") {
        status1[i].removeWhere((key, value) => value == false || value == true);
        status1[i].addAll(
            <String,dynamic>{
              "isSelected": false,
            }
        );
      }
    }
    graphName1 = name;
    notifyListeners();
  }

  String graphName2 = "";
  onGet2(int id,String name) async {
    final graphs = await Graph.getGraph();
    String tfText = graphs[id].text;
    int i;
    for (i = 0; i <= 168; i++) {
      String isTF = tfText[i];
      if (isTF == "T") {
        status2[i].removeWhere((key, value) => value == false || value == true);
        status2[i].addAll(
            <String,bool>{
              "isSelected": true,
            }
        );
      }
      else if (isTF == "F") {
        status2[i].removeWhere((key, value) => value == false || value == true);
        status2[i].addAll(
            <String,dynamic>{
              "isSelected": false,
            }
        );
      }
    }
    graphName2 = name;
    notifyListeners();
  }
}