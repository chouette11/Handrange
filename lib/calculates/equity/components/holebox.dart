import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/cardbox.dart';
import '../select_page.dart';

class HoleBox extends StatelessWidget {
  HoleBox({Key? key, required this.num, required this.cardHole}) : super(key: key);
  final int num;
  final List<String> cardHole;
  @override
  Widget build(BuildContext context) {

    List<Widget> cardBoxes = <Widget>[
      cardBox(null, null),
      cardBox(null, null),
    ];

    var index = 0;
    if (index < 2) {
      cardHole.forEach((element) {
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
      });
    }

    return Column(
      children: [
        GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => SelectPageEq(name: "hole$num"),
              );
            },
            child: Row(
              children: cardBoxes,
            )
        ),
      ],
    );
  }
}