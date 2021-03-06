import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/cardbox.dart';

class BoardBoxes extends StatelessWidget {
  BoardBoxes({Key? key, required this.boardCard, required this.selectPage,}) : super (key: key);
  final List<String> boardCard;
  final Widget selectPage;

  @override
  Widget build(BuildContext context) {
    List<Widget> cardBoxes = <Widget>[
      cardBox(null, null),
      cardBox(null, null),
      cardBox(null, null),
      cardBox(null, null),
      cardBox(null, null),
    ];

    var index = 0;

    boardCard.forEach((element) {
      if (index < 5) {
        int? num;
        String? mark;
        List<String> split = element.split('');
        if (split.length == 2) {
          num = int.parse(split[0]);
          mark = split[1];
        } else if (split.length == 3) {
          mark = split[2];
          split.removeLast();
          num = int.parse(split.join());
        }
        cardBoxes[index] = cardBox(num, mark);
        index++;
      }
    });

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => selectPage,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: cardBoxes
        ),
      ),
    );
  }
}