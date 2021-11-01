import 'package:flutter/cupertino.dart';
import 'package:handrange/calculates/equity/models/calculation_model.dart';
import 'package:handrange/data/combination.dart';

class EquityPageModel extends ChangeNotifier {
  List<String> cardHole1 = [];
  List<String> cardHole2 = [];
  List<String> boardCard = [];
  bool isRange = false;
  List<double> percent = [];
  double heroPercent = 0.00;
  double oppPercent = 0.00;

  equity(BuildContext context) {
    percent = calculate(cardHole1, cardHole2, status1, boardCard, context, isRange);
    heroPercent = percent[0];
    oppPercent = percent[1];
    notifyListeners();
  }

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