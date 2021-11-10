import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/calculates/components/calculation_model.dart';
import 'package:handrange/components/functions/elements.dart';
import '../../../data/combination.dart';
import 'package:flutter/material.dart';

class HandPageModel extends ChangeNotifier {
  List<String>boardCard = [];
  bool isColor = true;

  addBoard(int num, String mark, String card) {
    if (boardCard.every((element) => element != card)) {
      boardCard.add(card);
      final selectedCard = cards.firstWhere((e) => e["card"] == card);
      selectedCard["isColor"] = !selectedCard["isColor"];
      notifyListeners();
    }
  }

  bool isVisible = false;
  onVisible() {
    isVisible = true;
    notifyListeners();
  }

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

  List<int> comboList = [0,0,0,0,0,0,0,0,0,0];
  void calculate(List<Map<String, dynamic>> range, List<String> board) {
    comboList = [0,0,0,0,0,0,0,0,0,0];
    int heroSum = 0;
    int oppSum = 0;
    int sum = 0;

    void winPlayer(List<int>? opponent){
      int i = opponent![0];
      comboList[i]++;
      comboList[0]++;
    }

    range.forEach((element) {
      if (element['isSelected'] == true) {
        List<String> hole = [];
        handToNum(element['hand'][0], hole);
        handToNum(element['hand'][1], hole);

        List<String> marks = ['s', 'c', 'h', 'd'];
        if (element['hand'].length == 2) {
          for (int j = 0; j <= 2; j++) {
            for (int k = j + 1; k <= 3; k++) {
              List<String> oppBoard = List.from(board);

              String oppCard1 = hole[0] + marks[j];
              String oppCard2 = hole[1] + marks[k];
              if (board.every((element) =>
              element != oppCard1 && element != oppCard2)) {
                oppBoard.add(oppCard1);
                oppBoard.add(oppCard2);
                winPlayer(handJudge(oppBoard));
              }
            }
          }
        } else if (element['hand'][2] == 'o') {
          for (int j = 0; j <= 2; j++) {
            for (int k = j + 1; k <= 3; k++) {
              List<String> oppBoard = List.from(board);

              String oppCard1 = hole[0] + marks[j];
              String oppCard2 = hole[1] + marks[k];
              if (board.every((element) =>
              element != oppCard1 && element != oppCard2)) {
                oppBoard.add(oppCard1);
                oppBoard.add(oppCard2);
                winPlayer(handJudge(oppBoard));
              }

              List<String> oppBoard2 = List.from(board);

              String oppCard3 = hole[0] + marks[k];
              String oppCard4 = hole[1] + marks[j];
              if (board.every((element) =>
              element != oppCard1 && element != oppCard2)) {
                oppBoard2.add(oppCard3);
                oppBoard2.add(oppCard4);
                winPlayer(handJudge(oppBoard2));
              }
            }
          }
        } else {
          for (int i = 0; i < 4; i++) {
            List<String> oppBoard = List.from(board);

            String oppCard1 = hole[0] + marks[i];
            String oppCard2 = hole[1] + marks[i];
            if (board.every((element) =>
            element != oppCard1 && element != oppCard2)) {
              oppBoard.add(oppCard1);
              oppBoard.add(oppCard2);
              winPlayer(handJudge(oppBoard));
            }
          }
        }
      }
    });
    sum = heroSum + oppSum;
    List<double> percent = [];
    percent.add(heroSum/sum);
    percent.add(oppSum/sum);
  }
}

