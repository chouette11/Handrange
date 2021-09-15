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

List<String> addHandInfinity(List<String> holeList, List<String> boardList) {
  List<String> list = [];
  holeList.forEach((element) {list.add(element);});
  boardList.forEach((element) {list.add(element);});
  list.sort();
  if (list.length == 5) {

  }
  return list;
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
    break;
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
        flushNum.sort();
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
      list.add(numList[i]);
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
            list.add(numList[k]); // ThreeCard以外の場合、追加
          }
        }
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
  list.add(numList[i]);
  list.add(handNum);
  return list.reversed.toList();
}

List<int>? handJudge(List<int> numList, List<String> markList, List<String> cardList) {
  if (_isFourCard(numList) != null) {
    return _isFourCard(numList);
  }
  if (_isFullHouse(numList) != null) {
    return _isFullHouse(numList);
  }
  if (_isFlush(markList, cardList) != null) {
    return _isFlush(markList, cardList);
  }
  if (_isStraight(numList) != null) {
    return _isStraight(numList);
  }
  if (_isStraight(numList) != null) {
    return _isThreeCards(numList);
  }
  if (_isTwoPair(numList) != null) {
    return _isTwoPair(numList);
  }
  if (_isOnePair(numList) != null) {
    return _isOnePair(numList);
  }
  return numList.reversed.toList();
}

int winPlayer(List<int>? player1, List<int>? player2){
  print(player1);
  print(player2);
  if (player1![0] > player2![0]) {
    return 1;
  } else if (player1[0] < player2[0]) {
    return 2;
  } else {
    for (int i = 0; i < player1.length; i++) {
      if (player1[i] != player2[i]) {
        if (player1[i] > player2[i]) {
          return 1;
        } else {
          return 2;
        }
      }
    }
    return 0;
  }
}

void judgePlayer(List<int> numList, List<String> markList, List<String> cardList) {
  List<String> list = [];
  holeList.forEach((element) {list.add(element);});
  boardList.forEach((element) {list.add(element);});
  list.sort();
  return list;
}

void addRange(List<Map<String, dynamic>> range, ) {
  range.forEach((element) {
    List<int> numHole = [];
    List<String> markHole = [];
    List<String> cardHole = [];
    if (element["isSelected"] == true) {
      switch (element["hand"][0]) {
        case 'A':
          numHole.add(14);
          cardHole.add(14.toString());
          break;
        case 'K':
          numHole.add(13);
          cardHole.add(13.toString());
          break;
        case 'Q':
          numHole.add(12);
          cardHole.add(12.toString());
          break;
        case 'J':
          numHole.add(11);
          cardHole.add(11.toString());
          break;
        case 'T':
          numHole.add(10);
          cardHole.add(10.toString());
          break;
        case '9':
          numHole.add(9);
          cardHole.add(9.toString());
          break;
        case '8':
          numHole.add(8);
          cardHole.add(8.toString());
          break;
        case '7':
          numHole.add(7);
          cardHole.add(7.toString());
          break;
        case '6':
          numHole.add(6);
          cardHole.add(6.toString());
          break;
        case '5':
          numHole.add(5);
          cardHole.add(5.toString());
          break;
        case '4':
          numHole.add(4);
          cardHole.add(4.toString());
          break;
        case '3':
          numHole.add(3);
          cardHole.add(3.toString());
          break;
        case '2':
          numHole.add(2);
          cardHole.add(2.toString());
          break;
      }
      switch (element["hand"][1]) {
        case 'A':
          numHole.add(14);
          cardHole.add(14.toString());
          break;
        case 'K':
          numHole.add(13);
          cardHole.add(13.toString());
          break;
        case 'Q':
          numHole.add(12);
          cardHole.add(12.toString());
          break;
        case 'J':
          numHole.add(11);
          cardHole.add(11.toString());
          break;
        case 'T':
          numHole.add(10);
          cardHole.add(10.toString());
          break;
        case '9':
          numHole.add(9);
          cardHole.add(9.toString());
          break;
        case '8':
          numHole.add(8);
          cardHole.add(8.toString());
          break;
        case '7':
          numHole.add(7);
          cardHole.add(7.toString());
          break;
        case '6':
          numHole.add(6);
          cardHole.add(6.toString());
          break;
        case '5':
          numHole.add(5);
          cardHole.add(5.toString());
          break;
        case '4':
          numHole.add(4);
          cardHole.add(4.toString());
          break;
        case '3':
          numHole.add(3);
          cardHole.add(3.toString());
          break;
        case '2':
          numHole.add(2);
          cardHole.add(2.toString());
          break;
      }
    }
    String hand = element['hand'];
    List<String> marks = ['s', 'c', 'h', 'd'];

    if (hand.endsWith('o')) {
      for (int i = 0; i < 4; i++) {
        for (int j = i + 1; j < 4; j++) {
          markHole.add(marks[i]);
          markHole.add(marks[j]);
          cardHole.add(marks[i]);

        }
      }
    } else if (hand.endsWith('s')) {
      for (int i = 0; i < 4; i++) {
        markHole.add(marks[i]);
        markHole.add(marks[i]);
      }
    } else {
      for (int i = 0; i < 4; i++) {
        for (int j = i + 1; j < 4; j++) {
          markHole.add(marks[i]);
          markHole.add(marks[j]);
          cardHole.add(marks[i]);

        }
      }
    }
  });
}
