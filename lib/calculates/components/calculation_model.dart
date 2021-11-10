import 'package:flutter/material.dart';
import 'package:handrange/data/combination.dart';

List<int> addInt(List<int> holeList, List<int> boardList) {
  List<int> list = [];
  holeList.forEach((element) {list.add(element);});
  boardList.forEach((element) {list.add(element);});
  list.sort();
  return list;
}

List<String> addHand(List<String> holeList, List<String> boardList) {
  List<String> list = [];
  holeList.forEach((element) {list.add(element);});
  boardList.forEach((element) {list.add(element);});
  list.sort();
  return list;
}

List<double> calculate(List<String> heroHand, List<String> oppHand, List<Map<String, dynamic>> oppRange, List<String> board, BuildContext context, bool isRange) {
  int heroSum = 0;
  int oppSum = 0;
  int sum = 0;

  void winPlayer(List<int>? hero, List<int>? opponent){
    for (int i = 0; i < hero!.length; i++) {
      if (hero[i] > opponent![i]) {
        heroSum++;
        break;
      } else if (hero[i] < opponent[i]) {
        oppSum++;
        break;
      } else if (i == hero.length - 1) {
        heroSum++;
        oppSum++;
      }
    }
  }

  List<String> heroBoard = List.from(board);
  heroBoard.add(heroHand[0]);
  heroBoard.add(heroHand[1]);

  if (isRange == true) {
    oppRange.forEach((element) {
      if (element['isSelected'] == true) {
        List<String> hole = [];
        handToNum(element['hand'][0], hole);
        handToNum(element['hand'][1], hole);

        List<String> marks = ['s', 'c', 'h', 'd'];
        if (element['hand'][2] == 's') {
          for (int i = 0; i < 4; i++) {
            List<String> oppBoard = List.from(board);

            String oppCard1 = hole[0] + marks[i];
            String oppCard2 = hole[1] + marks[i];
            if (heroBoard.every((element) =>
            element != oppCard1 && element != oppCard2)) {
              oppBoard.add(oppCard1);
              oppBoard.add(oppCard2);

              if (board.length == 3) {
                CARDS.forEach((card1) {
                  if (heroHand.every((element) => element != card1["card"]) &&
                      oppBoard.every((element) => element != card1["card"])) {
                    CARDS.forEach((card2) {
                      if (heroHand.every((element) =>
                      element != card2["card"]) &&
                          oppBoard.every((element) =>
                          element != card2["card"]) &&
                          card1["card"] != card2["card"]) {
                        List<String> ipHeroBoard = List.from(heroBoard);
                        List<String> ipOppBoard = List.from(oppBoard);
                        ipHeroBoard.add(card1["card"]);
                        ipOppBoard.add(card1["card"]);
                        ipHeroBoard.add(card2["card"]);
                        ipOppBoard.add(card2["card"]);
                        winPlayer(
                            handJudge(ipHeroBoard), handJudge(ipOppBoard));
                      }
                    });
                  }
                });
              } else if (board.length == 4) {
                CARDS.forEach((card1) {
                  if (heroHand.every((element) => element != card1["card"]) &&
                      oppBoard.every((element) => element != card1["card"])) {
                    List<String> ipHeroBoard = List.from(heroBoard);
                    List<String> ipOppBoard = List.from(oppBoard);
                    ipHeroBoard.add(card1["card"]);
                    ipOppBoard.add(card1["card"]);
                    winPlayer(handJudge(ipHeroBoard), handJudge(ipOppBoard));
                  }
                });
              } else if (board.length == 5) {
                winPlayer(handJudge(heroBoard), handJudge(oppBoard));
              } else {
                showDialog(context: context,
                  builder: (_) =>
                      SimpleDialog(
                        title: Text("エラー"),
                        children: <Widget>[
                          SimpleDialogOption(
                            child: Text('ボードのカードを３枚以上選択してください'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                );
              }
            }
          }
        }
      }
    });
  } else {
    List<String> oppBoard = List.from(board);
    oppBoard.add(oppHand[0]);
    oppBoard.add(oppHand[1]);

    if (board.length == 3) {
      CARDS.forEach((card1) {
        if (heroHand.every((element) => element != card1["card"]) &&
            oppBoard.every((element) => element != card1["card"])) {
          CARDS.forEach((card2) {
            if (heroHand.every((element) =>
            element != card2["card"]) &&
                oppBoard.every((element) =>
                element != card2["card"]) &&
                card1["card"] != card2["card"]) {
              List<String> ipHeroBoard = List.from(heroBoard);
              List<String> ipOppBoard = List.from(oppBoard);
              ipHeroBoard.add(card1["card"]);
              ipOppBoard.add(card1["card"]);
              ipHeroBoard.add(card2["card"]);
              ipOppBoard.add(card2["card"]);
              winPlayer(
                  handJudge(ipHeroBoard), handJudge(ipOppBoard));
            }
          });
        }
      });
    } else if (board.length == 4) {
      CARDS.forEach((card1) {
        if (heroHand.every((element) => element != card1["card"]) &&
            oppBoard.every((element) => element != card1["card"])) {
          List<String> ipHeroBoard = List.from(heroBoard);
          List<String> ipOppBoard = List.from(oppBoard);
          ipHeroBoard.add(card1["card"]);
          ipOppBoard.add(card1["card"]);
          winPlayer(handJudge(ipHeroBoard), handJudge(ipOppBoard));
        }
      });
    } else if (board.length == 5) {
      winPlayer(handJudge(heroBoard), handJudge(oppBoard));
    } else {
      showDialog(context: context,
        builder: (_) =>
            SimpleDialog(
              title: Text("エラー"),
              children: <Widget>[
                SimpleDialogOption(
                  child: Text('ボードのカードを３枚以上選択してください'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
      );
    }
  }
  sum = heroSum + oppSum;
  List<double> percent = [];
  percent.add(heroSum/sum);
  percent.add(oppSum/sum);
  return percent;
}


List<int>? handJudge(List<String> cardList) {
  List<int> numList = [];
  List<String> markList = [];
  List<List<String>> split = [];

  cardList.forEach((element) { // マークと数字を分ける
    split.add(element.split(""));
  });
  split.forEach((element) { // マークを代入
    markList.add(element.last);
  });
  split.forEach((element) { // マークを削除する
    element.removeLast();
  });
  split.forEach((element) { // 10,11,12,13,14を処理して、代入
    element.length == 2
        ? numList.add(int.parse(element.join("")))
        : numList.add(int.parse(element[0]));
  });
  numList.sort((a, b) => b - a); // 大きい順
  markList.sort();

  if (_isFourCard(numList) != null) {
    List<int> _newIsFourCard = List.generate(3, (index) => _isFourCard(numList)![index]);
    return _newIsFourCard;
  }
  if (_isFullHouse(numList) != null) {
    return _isFullHouse(numList);
  }
  if (_isFlush(markList, cardList) != null) {
    List<int> _newIsFlush = List.generate(6, (index) => _isFlush(markList, cardList)![index]);
    return _newIsFlush;
  }
  if (_isStraight(numList) != null) {
    return _isStraight(numList);
  }
  if (_isThreeCards(numList) != null) {
    List<int> _newIsThreeCard = List.generate(4, (index) => _isThreeCards(numList)![index]);
    return _newIsThreeCard;
  }
  if (_isTwoPair(numList) != null) {
    List<int> _newIsTwoPair = List.generate(4, (index) => _isTwoPair(numList)![index]);
    return _newIsTwoPair;
  }
  if (_isOnePair(numList) != null) {
    List<int> _newIsOnePair = List.generate(5, (index) => _isOnePair(numList)![index]);
    return _newIsOnePair;
  }
  numList.sort();
  numList.add(0);
  return numList.reversed.toList();
}

void handToNum(String hand, List<String> hole) {
  switch (hand) {
    case 'A':
      hole.add("14");
      break;
    case 'K':
      hole.add("13");
      break;
    case 'Q':
      hole.add("12");
      break;
    case 'J':
      hole.add("11");
      break;
    case 'T':
      hole.add("10");
      break;
    case '9':
      hole.add("9");
      break;
    case '8':
      hole.add("8");
      break;
    case '7':
      hole.add("7");
      break;
    case '6':
      hole.add("6");
      break;
    case '5':
      hole.add("5");
      break;
    case '4':
      hole.add("4");
      break;
    case '3':
      hole.add("3");
      break;
    case '2':
      hole.add("2");
      break;
  }
}

List<int>? _isFourCard(List<int> numList) {
  for (int i = 0; i <= numList.length - 4; i++) {
    if ((numList[i] == numList[i + 1] && numList[i] == numList[i + 2] &&
        numList[i] == numList[i + 3])) {
      print("FourCards");
      return _result(7, numList, i);
    }
  }
}

List<int>? _isFullHouse(List<int> numList) {
  for (int i = 0; i <= numList.length - 5; i++) {
    for (int j = i + 3; j <= numList.length - 2; j++) {
      if ((numList[i] == numList[i + 1] && numList[i] == numList[i + 2]) &&
          numList[j] == numList[j + 1]) {
        List<int> list = [6];
        list.add(numList[i]);
        list.add(numList[j]);
        print("FullHouse");
        return list;
      }
    }
  }
  for (int i = 2; i <= numList.length - 3; i++) {
    for (int j = i - 2; j >= 0; j--) {
      if ((numList[i] == numList[i + 1] && numList[i] == numList[i + 2]) &&
          numList[j] == numList[j + 1]) {
        List<int> list = [6];
        list.add(numList[i]);
        list.add(numList[j]);
        print("FullHouse");
        return list;
      }
    }
  }
}

List<int>? _isFlush(List<String> markList, List<String> cardList) {
  List<String> mark = ["s","c","h","d"];

  for (int i = 0; i <= markList.length - 5; i++) {
    for(int j = 0; j <= 3; j++){
      if (markList[i].contains(mark[j]) && markList[i + 1].contains(mark[j]) &&
          markList[i + 2].contains(mark[j]) && markList[i + 3].contains(mark[j]) &&
          markList[i + 4].contains(mark[j])) {
        List<String> judge = [];
        List<List<String>> split = [];
        List<int> flushNum = [];

        cardList.forEach((element) { // flushのマークが含まれているか
          element.contains(mark[j]) ? judge.add(element) : judge = judge;
        });
        judge.forEach((element) { // マークと数字を分ける
          split.add(element.split(""));
        });
        split.forEach((element) { // マークを削除する
          element.removeLast();
        });
        split.forEach((element) { // 10,11,12,13,14を処理して、代入
          element.length == 2
              ? flushNum.add(int.parse(element.join("")))
              : flushNum.add(int.parse(element[0]));
        });
        flushNum.sort(); // 小さい順
        flushNum.add(5);
        print("flush");
        return flushNum.reversed.toList();
      }
    }
  }
}

List<int>? _isStraight(List<int> numList) {
  for (int i = 10; i >= 2; i--) {
    if (numList.contains(i) && numList.contains(i + 1) &&
        numList.contains(i + 2) && numList.contains(i + 3) &&
        numList.contains(i + 4)) {
      print("Straight");
      List<int> list = [4];
      list.add(i);
      return list;
    }
  }
  if(numList.contains(14) && numList.contains(2) &&
      numList.contains(3) && numList.contains(4) &&
      numList.contains(5)){
    List<int> list = [4];
    list.add(1);
    print("Straight");
    return list;
  }
}

List<int>? _isThreeCards(List<int> numList) {
  for (int i = 0; i <= numList.length - 3; i++) {
    if (numList[i] == numList[i + 1] && numList[i] == numList[i + 2]) {
      print("ThreeCards");
      return _result(3, numList, i);
    }
  }
}

List<int>? _isTwoPair(List<int> numList) {
  for (int i = 0; i <= numList.length - 4; i++) {
    for (int j = i + 2; j <= numList.length - 2; j++) {
      if (numList[i] == numList[i + 1] && numList[j] == numList[j + 1]) {
        print("TwoPair");
        List<int> list = [];
        for (int k = 0; k < numList.length; k++) {
          if (numList[i] != numList[k] && numList[j] != numList[k]) {
            list.add(numList[k]); // TwoPair以外の場合、追加
          }
        }
        list.sort(); // 小さい順
        list.add(numList[j]);
        list.add(numList[i]);
        list.add(2);
        return list.reversed.toList();
      }
    }
  }
}

List<int>? _isOnePair(List<int> numList) {
  for (int i = 0; i <= numList.length - 2; i++) {
    if (numList[i] == numList[i + 1]) {
      print("OnePair");
      return _result(1, numList, i);
    }
  }
}

List<int> _result(int handNum, List<int> numList, int i) {
  List<int> list = [];
  for (int k = 0; k < numList.length; k++) {
    if (numList[i] != numList[k]) {
      list.add(numList[k]); // ThreeCard以外の場合、追加
    }
  }
  list.sort(); // 小さい順
  list.add(numList[i]);
  list.add(handNum);
  return list.reversed.toList();
}
