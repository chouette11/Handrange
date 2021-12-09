import 'package:flutter/cupertino.dart';
import 'package:handrange/calculates/calculation_model.dart';
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
    boardCard.clear();
    cardHole1.clear();
    cardHole2.clear();
    percent.clear();
    heroPercent = 0.00;
    oppPercent = 0.00;
    status1.forEach((element) {
      element['isSelected'] = false;
    });
    onReset();
    notifyListeners();
  }

  onIndivClear(List<String> cardList) {
    cardList.forEach((card) {
      final selectedCard = cards.firstWhere((e) => e["card"] == card);
      selectedCard["isColor"] = true;
    });
    cardList.clear();
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

  double time() {
    int count = 0;
    status1.forEach((element) {
      if(element['isSelected'] == true) {
        if(element['hand'].length == 2) {
          count += 6;
        } else if (element['hand'][2] == 'o') {
          count += 12;
        } else if (element['hand'][2] == 's') {
          count += 4;
        }
      }
    });
    if (isRange == false) {
      return 1;
    } else if (boardCard.length == 3) {
      double percent = (count / 1326) * 100;
      return percent * 15;
    } else if (boardCard.length == 4) {
      double percent = (count / 1326) * 100;
      return percent * 3;
    } else {
      return 1;
    }
  }

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
}