import 'package:flutter/cupertino.dart';
import 'package:handrange/components/functions/elements.dart';
import 'package:handrange/data/combination.dart';

class EquityPageModel extends ChangeNotifier {
  List<int> numHole1 = [];
  List<int> numHole2 = [];

  List<String> markHole1 = [];
  List<String> markHole2 = [];

  List<String> cardHole1 = [];
  List<String> cardHole2 = [];

  List<int>board = [];
  List<String>boardMark = [];
  List<String>boardCard = [];

  onClear() {
    board.clear();
    boardMark.clear();
    boardCard.clear();
    onReset();
    notifyListeners();
  }

  addBoard(int num, String mark, String card) {
    if (boardCard.every((element) => element != card) &&
        cardHole1.every((element) => element != card) &&
        cardHole2.every((element) => element != card)) {
      board.add(aceTo14(num));
      boardMark.add(mark);
      boardCard.add(card);
      final selectedCard = cards.firstWhere((e) => e["card"] == card);
      selectedCard["isColor"] = !selectedCard["isColor"];
      notifyListeners();
    }
  }

  addHole1(int num, String mark, String card) {
    if (boardCard.every((element) => element != card) &&
        cardHole1.every((element) => element != card) &&
        cardHole2.every((element) => element != card)) {
      numHole1.add(aceTo14(num));
      markHole1.add(mark);
      cardHole1.add(card);
      final selectedCard = cards.firstWhere((e) => e["card"] == card);
      selectedCard["isColor"] = !selectedCard["isColor"];
      notifyListeners();
    }
  }

  addHole2(int num, String mark, String card) {
    if (boardCard.every((element) => element != card) &&
        cardHole1.every((element) => element != card) &&
        cardHole2.every((element) => element != card)) {
      numHole2.add(aceTo14(num));
      markHole2.add(mark);
      cardHole2.add(card);
      final selectedCard = cards.firstWhere((e) => e["card"] == card);
      selectedCard["isColor"] = !selectedCard["isColor"];
      notifyListeners();
    }
  }

  //selectBoard
  List<Map<String, dynamic>> cards = CARDS.map((e) => {
    "num": e["num"],
    "mark": e["mark"],
    "card": e["card"],
    "isColor": true,
  }).toList();

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
}