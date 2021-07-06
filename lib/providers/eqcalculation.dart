import 'package:flutter/cupertino.dart';
import 'package:handrange/components/functions/elements.dart';
import 'package:handrange/datas/combination.dart';
import 'package:handrange/datas/sql.dart';

class EqCalculation extends ChangeNotifier {
  List<int> hole1 = [];
  List<int> hole2 = [];

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

  graphJudge() {
    List<int> numbers = [];
    numbers.add(aceTo14(num1));
    numbers.add(aceTo14(num2));
    numbers.add(aceTo14(num3));

    if(num4 != 0){
      numbers.add(aceTo14(num4));
    }

    if(num5 != 0){
      numbers.add(aceTo14(num5));
    }
    numbers.sort();
    List<int> board = List.from(numbers);

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

    List<String> mark = ["s", "c", "h", "d"];
    // List <String> selectedMark = ["ss","cc","hh","dd"];
    int i, j;
    int max = numbers.length;

    onCalculate(List<int> numbers, List<String> marks, List<String> cards, int result, int ver, String flushMark) {
      for(i = 0; i <= 3; i++){
        if(cards.contains("13${mark[i]}") && cards.contains("12${mark[i]}")
            && cards.contains("11${mark[i]}") && cards.contains("10${mark[i]}") && cards.contains("14${mark[i]}")){
          print("Royal");
          result = 9;
        }
      }
      for(i = 2; i <= 9; i++){
        for(j = 0; j <= 3; j++){
          if (cards.contains("$i${mark[j]}") && cards.contains("${i + 1}${mark[j]}") &&
              cards.contains("${i + 2}${mark[j]}") && cards.contains("${i + 3}${mark[j]}") &&
              cards.contains("${i + 4}${mark[j]}")) {
            print("StraightFlush");
            result = 8;
            break;
          }
        }
      }
      for (i = 0; i <= max - 4; i++) {
        if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2] &&
            numbers[i] == numbers[i + 3])) {
          print("FourCards");
          result = 7;
          //TODO kicker
          break;
        }
      }
      for (i = 0; i <= max - 5; i++) {
        for (j = i + 3; j <= max - 2; j++) {
          if ((numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) &&
              numbers[j] == numbers[j + 1]) {
            print("FullHouse");
            result = 6;
            ver = 1;
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
            result = 6;
            ver = 2;
            break;
          }
        }
        break;
      }
      for (i = 0; i <= max - 5; i++) {
        for(j = 0; j <= 3; j++){
          if (marks[i].contains(mark[j]) && marks[i + 1].contains(mark[j]) && marks[i + 2].contains(mark[j]) &&  marks[i + 3].contains(mark[j]) && marks[i + 4].contains(mark[j])) {
            print("flush");
            result = 5;
            flushMark = mark[j];
            break;
          }
        }
      }
      for (i = 10; i >= 2; i--) {
        if (numbers.contains(i) && numbers.contains(i + 1) &&
            numbers.contains(i + 2) && numbers.contains(i + 3) &&
            numbers.contains(i + 4)) {
          print("Straight");
          result = 4;
          ver = i;
          break;
        }
      }
      if(numbers.contains(14) && numbers.contains(2) &&
          numbers.contains(3) && numbers.contains(4) &&
          numbers.contains(5)){
        print("Straight");
        result = 4;
        ver = 1;
      }
      for (i = 0; i <= max - 3; i++) {
        if (numbers[i] == numbers[i + 1] && numbers[i] == numbers[i + 2]) {
          print("ThreeCards");
          result = 3;
          break;
        }
      }
      for (i = 0; i <= max - 4; i++) {
        for (j = i + 2; j <= max - 2; j++) {
          if (numbers[i] == numbers[i + 1] && numbers[j] == numbers[j + 1]) {
            print("TwoPair");
            result = 2;
            break;
          }
        }
      }
      for (i = 0; i <= max - 2; i++) {
        if (numbers[i] == numbers[i + 1]) {
          print("OnePair");
          result = 1;
          break;
        }
      }
    }
    //end onCalculate

    int ver1 = 0;
    int ver2 = 0;
    hole1.sort((a, b) => a.compareTo(b));
    hole2.sort((a, b) => a.compareTo(b));
    String flushMark = "";

    List<int> numbers1 = List.from(numbers);
    int num6 = aceTo14(hole1[0]);
    int num7 = aceTo14(hole1[1]);
    numbers1.add(num6);
    numbers1.add(num7);
    numbers1.sort((a, b) => a.compareTo(b));

    List<String> marks1 = List.from(marks);
    String mark6 = mark1_1;
    String mark7 = mark1_2;
    marks1.add(mark6);
    marks1.add(mark7);
    marks1.sort((a, b) => a.compareTo(b));

    List<String> cards1 = List.from(cards);
    String card6 = "$num6$mark6";
    String card7 = "$num7$mark7";
    cards1.add(card6);
    cards1.add(card7);

    List<String> nums1 = [];
    List<List<String>> numm1 = [];
    List<int> strFlush1 = [];
    cards1.forEach((element) {element.contains(flushMark) ? nums1.add(element) : nums1 = nums1;});
    nums1.forEach((element) {numm1.add(element.split(""));});
    numm1.forEach((element) {element.removeLast();});
    numm1.forEach((element) {
      element.length == 2 ? strFlush1.add(int.parse(element.join(""))) : strFlush1.add(int.parse(element[0]));
    });
    strFlush1.sort();

    int result1 = 0;
    onCalculate(numbers1,marks1,cards1,result1,ver1,flushMark);

    List<int> numbers2 = List.from(numbers);
    num6 = aceTo14(hole2[0]);
    num7 = aceTo14(hole2[1]);
    numbers2.add(num6);
    numbers2.add(num7);
    numbers2.sort((a, b) => a.compareTo(b));

    List<String> marks2 = List.from(marks);
    mark6 = mark2_2;
    mark7 = mark2_2;
    marks2.add(mark6);
    marks2.add(mark7);
    marks2.sort((a, b) => a.compareTo(b));

    List<String> cards2 = List.from(cards);
    card6 = "$num6$mark6";
    card7 = "$num7$mark7";
    cards2.add(card6);
    cards2.add(card7);

    List<String> nums2 = [];
    List<List<String>> numm2 = [];
    List<int> strFlush2 = [];
    cards2.forEach((element) {element.contains(flushMark) ? nums2.add(element) : nums1 = nums1;});
    nums2.forEach((element) {numm2.add(element.split(""));});
    numm2.forEach((element) {element.removeLast();});
    numm2.forEach((element) {
      element.length == 2 ? strFlush2.add(int.parse(element.join(""))) : strFlush2.add(int.parse(element[0]));
    });
    strFlush2.sort();


    int result2 = 0;
    onCalculate(numbers2, marks2, cards2, result2, ver2,flushMark);

    double player1 = 0;
    double player2 = 0;
    if (num5 != 0) {
      if (result1 > result2){
        player1 = 1;
      } else if (result2 > result1) {
        player2 = 1;
      } else {
        if (result1 == 9) {

        } else if (result1 == 8) {

        } else if (result1 == 7) { //fourCards
          for (i = 0; i <= 1; i++) {
            if ((board[i] == board[i + 1] && board[i] == board[i + 2] && board[i] == board[i + 3])){ //board fourCards
              if (i == 0) {
                if (hole1[0] > board[4] || hole2[0] > board[4]) {
                  hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
                }
              } else if (i == 1) {
                if (hole1[0] > board[0] || hole2[0] > board[0]) {
                  hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
                }
              }
            } else {
              numbers1[3] > numbers2[3] ? player1 = 1 : player2 = 1;
            }
          }
        } else if (result1 == 6) { //fullHouse
          if (ver1 == 1 && ver2 == 1) {
            numbers1[2] > numbers2[2] ? player1 = 1 : player2 = 1;
          } else if (ver1 == 1 && ver2 == 2) {
            numbers1[2] > numbers2[4] ? player1 = 1 : player2 = 1;
          } else if (ver1 == 2 && ver2 == 1) {
            numbers1[4] > numbers2[2] ? player1 = 1 : player2 = 1;
          } else if (ver1 == 2 && ver2 == 2) {
            numbers1[4] > numbers2[4] ? player1 = 1 : player2 = 1;
          }
        } else if (result1 == 5) { // flush
          if {
            for (i = st) {
              if (strFlush1[i] > strFlush2[i]) {
                player1 = 1;
              } else if (strFlush2[i] > strFlush1[i]) {
                player2 = 1;
              }
            }
          }
        } else if (result1 == 4) { //straight
          ver1 > ver2 ? player1 = 1 : player2 = 1;
        } else if (result1 == 3) { //threeCards
          for (i = 0; i <= 2; i++) {
            if (board[i] == board[i + 1] && board[i] == board[i + 2]) { //board ThreeCards
              if (hole1[0] != hole2[0]) {
                if (i == 0 || i == 1) {
                  if (hole1[0] > board[4] || hole2[0] > board[4]) {
                    hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
                  } else if (i == 2) {
                    if (hole1[0] > board[1] || hole2[0] > board[1]) {
                      hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
                    }
                  }
                }
              } else if (hole1[0] == hole2[0]) {
                if (i == 0 || i == 1) {
                  if (hole1[1] > board[4] || hole2[1] > board[4]) {
                    hole1[1] > hole2[1] ? player1 = 1 : player2 = 1;
                  } else if (i == 2) {
                    if (hole1[1] > board[1] || hole2[1] > board[1]) {
                      hole1[1] > hole2[1] ? player1 = 1 : player2 = 1;
                    }
                  }
                }
              }
            } else if (board[i] == board[i + 1]) { //board onePair
              if (hole1[0] == board[i] && hole2[0] == board[i]) {
                hole1[1] > hole2[1] ? player1 = 1 : player2 = 1;
              } else if (hole1[1] == board[i] && hole2[0] == board[i]) {
                hole1[0] > hole2[1] ? player1 = 1 : player2 = 1;
              } else if (hole1[0] == board[i] && hole2[1] == board[i]) {
                hole1[1] > hole2[0] ? player1 = 1 : player2 = 1;
              } else if (hole1[1] == board[i] && hole2[1] == board[i]) {
                hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
              }
            } else { // set vs set
              hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
            }
          }
        } else if (result1 == 2) { // twoPair
          for (i = 0; i < 5; i++) {
            if ((board[0] == board[1] && board[2] == board[3]) ||
                (board[0] == board[1] && board[3] == board[4]) ||
                (board[1] == board[2] && board[3] == board[4])) { //board twoPair
              if (hole1[0] != hole2[0]) {
                hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
                break;
              } else if (hole1[0] == hole2[0]) {
                hole1[1] > hole2[1] ? player1 = 1 : player2 = 1;
                break;
              }
            } else if (board[i] == board[i + 1]) { //board onePair
              if (hole1[0] != hole2[0]) {
                hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
                break;
              } else if (hole1[0] == hole2[0]) {
                hole1[1] > hole2[1] ? player1 = 1 : player2 = 1;
                break;
              }
            }
          }
        } else if (result1 == 1) {
          if (board[0] == board[1] || board[1] == board[2] ||
              board[2] == board[3] || board[3] == board[4]) { //board onePair
            hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
          } else {
            hole1[0] > hole2[0] ? player1 = 1 : player2 = 1;
          }
        }
      }
    }
    notifyListeners();
  }

  //selectBoard
  List<Map<String, dynamic>> cards = CARDS.map((e) => {
    "num": e["num"],
    "mark": e["mark"],
    "card": e["card"],
    "isColor": true,
  }).toList();

  onTapped(String hand) {
    final tappedBox = cards.firstWhere((e) => e["card"] == hand);
    tappedBox["isColor"] = false;
  }

  onReset() {
    cards.forEach((element) {
      element["isColor"] = true;
    });
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