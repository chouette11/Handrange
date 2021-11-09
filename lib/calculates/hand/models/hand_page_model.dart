import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/components/functions/elements.dart';
import '../../../data/combination.dart';
import 'package:flutter/material.dart';

class HandPageModel extends ChangeNotifier {
  int num6 = 0;
  int num7 = 0;
  List<int>board = [];
  List<String>boardMark = [];
  List<String>boardCard = [];
  bool isColor = true;

  addBoard(int num, String mark, String card) {
    if (boardCard.every((element) => element != card)) {
      board.add(aceTo14(num));
      boardMark.add(mark);
      boardCard.add(card);
      final selectedCard = cards.firstWhere((e) => e["card"] == card);
      selectedCard["isColor"] = !selectedCard["isColor"];
      notifyListeners();
    }
  }

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
  List<int> onePairCombo = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];

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
    List<int> inputOnePairCombo = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];

    handJudge(String isSuit) {
      List <String> mark = ["s", "c", "h", "d"];
      int i, j, l, m;
      int k = 0;
      int max = board.length;

      onCalculate() {
        int judge = 0;
        for(i = 0; i <= 3; i++){
          if(boardCard.contains("13${mark[i]}") && boardCard.contains("12${mark[i]}")
              && boardCard.contains("11${mark[i]}") && boardCard.contains("10${mark[i]}") && boardCard.contains("1${mark[i]}")){
            print("Royal");
            inputRoyalStraightFlash++;
          }
        }
        for(i = 1; i <= 9; i++){
          for(j = 0; j <= 3; j++){
            if (boardCard.contains("$i${mark[j]}") && boardCard.contains("${i + 1}${mark[j]}") &&
                boardCard.contains("${i + 2}${mark[j]}") && boardCard.contains("${i + 3}${mark[j]}") &&
                boardCard.contains("${i + 4}${mark[j]}")) {
              print("StraightFlush");
              inputStraightFlush++;
              break;
            }
          }
        }
        for (i = 0; i <= max - 4; i++) {
          if ((board[i] == board[i + 1] && board[i] == board[i + 2] &&
              board[i] == board[i + 3])) {
            print("FourCards");
            inputFourCards++;
            break;
          }
        }
        for (i = 0; i <= max - 5; i++) {
          for (j = i + 3; j <= max - 2; j++) {
            if ((board[i] == board[i + 1] && board[i] == board[i + 2]) &&
                board[j] == board[j + 1]) {
              print("FullHouse");
              judge = 6;
              inputFullHouse++;
              break;
            }
          }
        }
        for (i = 2; i <= max - 3; i++) {
          for (j = i - 2; j >= 0; j--) {
            if ((board[i] == board[i + 1] && board[i] == board[i + 2]) &&
                board[j] == board[j + 1]) {
              print("FullHouse");
              judge == 6 ? inputFullHouse = inputFullHouse : inputFullHouse++;
              break;
            }
          }
        }
        for (i = 0; i <= max - 5; i++) {
          for(j = 0; j <= 3; j++){
            if (boardMark[i].contains(mark[j]) && boardMark[i + 1].contains(mark[j]) && boardMark[i + 2].contains(mark[j]) &&  boardMark[i + 3].contains(mark[j]) && boardMark[i + 4].contains(mark[j])) {
              print("flush");
              inputFlush++;
              break;
            }
          }
        }
        for (i = 1; i <= 8; i++) {
          if (board.contains(i) && board.contains(i + 1) &&
              board.contains(i + 2) && board.contains(i + 3) &&
              board.contains(i + 4)) {
            print("Straight");
            inputStraight++;
            judge = 4;
            break;
          }
        }
        if(board.contains(1) && board.contains(10) &&
            board.contains(11) && board.contains(12) &&
            board.contains(13)){
          print("Straight");
          judge == 4 ? inputStraight = inputStraight : inputStraight++;
        }
        for (i = 0; i <= max - 3; i++) {
          if (board[i] == board[i + 1] && board[i] == board[i + 2]) {
            print("ThreeCards");
            inputThreeCards++;
            break;
          }
        }
        for (i = 0; i <= max - 4; i++) {
          for (j = i + 2; j <= max - 2; j++) {
            if (board[i] == board[i + 1] && board[j] == board[j + 1]) {
              print("TwoPair");
              for (l = 0; l <= 3; l++) {
                if (board[l] == board[l + 1]) {
                  judge == 2 ? inputOnePairCombo = inputOnePairCombo : inputOnePairCombo[board[i]]++;
                }
              }
              judge == 2 ? inputTwoPair = inputTwoPair : inputTwoPair++;
              judge = 2;
              break;
            }
          }
        }
        for (i = 0; i <= max - 2; i++) {
          if (board[i] == board[i + 1]) {
            print("OnePair");
              if (board[k] != board[k + 1] && board[k] != board[k + 2] && board[k] != board[k + 3] && board[k] != board[k + 4]) {
                inputOnePairCombo[board[i]]++;
              }
            inputOnePair++;
            break;
          }
        }
      }
      //end onCalculate
      if (isSuit == "s") {
        for(l = 0; l <= 3; l++){
          String mark6 = mark[l];

          String card6 = "$num6$mark6";
          String card7 = "$num7$mark6";

          boardMark.add(mark6);
          boardMark.add(mark6);
          boardMark.sort((a, b) => a.compareTo(b));
          if((boardCard.every((hand) => hand != card6)) && (boardCard.every((hand) => hand != card7))){
            boardCard.add(card6);
            boardCard.add(card7);
            onCalculate();
            inputSum++;
          }
          boardMark.remove(mark6);boardMark.remove(mark6);boardCard.remove(card6);boardCard.remove(card7);
        }
      }
      else if(isSuit =="o"){
        for(m = 0; m <= 2; m++){
          for(l = m + 1; l <= 3; l++){
            String mark6 = mark[l];
            String mark7 = mark[m];

            String card6 = "$num6$mark6";
            String card7 = "$num7$mark6";

            boardMark.add(mark6);
            boardMark.add(mark7);
            boardMark.sort((a, b) => a.compareTo(b));

            if((boardCard.every((hand) => hand != card6)) && (boardCard.every((hand) => hand != card7))){
              boardCard.add(card6);
              boardCard.add(card7);
              onCalculate();
              inputSum++;
              onCalculate();
              inputSum++;
            }
            boardMark.remove(mark6);boardMark.remove(mark7);boardCard.remove(card6);boardCard.remove(card7);
          }
        }
      }
      else if(isSuit == "p"){
        for(m = 0; m <= 2; m++){
          for(l = m + 1; l <= 3; l++) {
            String mark6 = mark[l];
            String mark7 = mark[m];

            String card6 = "$num6$mark6";
            String card7 = "$num7$mark6";

            boardMark.add(mark6);
            boardMark.add(mark7);
            boardMark.sort((a, b) => a.compareTo(b));

            if((boardCard.every((hand) => hand != card6)) && (boardCard.every((hand) => hand != card7))){
              boardCard.add(card6);
              boardCard.add(card7);
              onCalculate();
              inputSum++;
            }
            boardMark.remove(mark6);boardMark.remove(mark7);boardCard.remove(card6);boardCard.remove(card7);
          }
        }
      }
    }
    status.forEach((element) {
      if (element["isSelected"] == true) {
        List<int> ipBoard = List.from(board);
        addHand(element["hand"], board);

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
        board = ipBoard;
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
    onePairCombo = inputOnePairCombo;
    sum = inputSum;
    notifyListeners();
  }

  void addHand(String hand, List<int> numList) {
    switch (hand[0]) {
      case 'A':
        numList.add(1);
        break;
      case 'K':
        numList.add(13);
        break;
      case 'Q':
        numList.add(12);
        break;
      case 'J':
        numList.add(11);
        break;
      case 'T':
        numList.add(10);
        break;
      case '9':
        numList.add(9);
        break;
      case '8':
        numList.add(8);
        break;
      case '7':
        numList.add(7);
        break;
      case '6':
        numList.add(6);
        break;
      case '5':
        numList.add(5);
        break;
      case '4':
        numList.add(4);
        break;
      case '3':
        numList.add(3);
        break;
      case '2':
        numList.add(2);
        break;
    }
    switch (hand[1]) {
      case 'A':
        numList.add(1);
        break;
      case 'K':
        numList.add(13);
        break;
      case 'Q':
        numList.add(12);
        break;
      case 'J':
        numList.add(11);
        break;
      case 'T':
        numList.add(10);
        break;
      case '9':
        numList.add(9);
        break;
      case '8':
        numList.add(8);
        break;
      case '7':
        numList.add(7);
        break;
      case '6':
        numList.add(6);
        break;
      case '5':
        numList.add(5);
        break;
      case '4':
        numList.add(4);
        break;
      case '3':
        numList.add(3);
        break;
      case '2':
        numList.add(2);
        break;
    }
  }
  //result
  List<String> onePairList = [];
  List<int> comboList = [0,0,0,0,0,0,0,0,0,0];
  createComboList() {
    int i;
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
    print(inputComboList);
    comboList = inputComboList;

    List<String> inputOnePairList = [];
    for (i = 0; i <= 12; i++) {
      if(onePairCombo[i] > 6) {
        inputOnePairList.add(
            "${returnNumber(i)}ペア:${((onePairCombo[i] / onePair) * 100).toStringAsFixed(2)}%"
        );
      }
    }
    onePairList = inputOnePairList;
    notifyListeners();
  }

  bool isVisible = false;
  onVisible() {
    isVisible = true;
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

  //GraphList
  List<Map<String, dynamic>> status = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
    "isSelected": false,
  }).toList();

}

