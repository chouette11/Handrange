import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:handrange/calculates/components/cardbox.dart';
import 'package:handrange/calculates/equity/equity_select_page.dart';
import 'package:handrange/calculates/equity/models/equity_page_model.dart';

class HoleBox extends StatelessWidget {
  HoleBox({Key? key, required this.num, required this.cardHole}) : super(key: key);
  final int num;
  final List<String> cardHole;
  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> cards = context.select<EquityPageModel, List<Map<String, dynamic>>>
      ((EquityPageModel model) => model.cards);

    List<int> numHole = [0, 0];
    List<String> markHole = ["", ""];

    var index = 0;
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
      if (index < 2) {
        numHole[index] = num!;
        markHole[index] = mark!;
      }
      index++;
    });

    List<Widget> cardBoxes = <Widget>[
      cardBox(numHole[0], markHole[0]),
      SizedBox(width: 8),
      cardBox(numHole[1], markHole[1]),
    ];

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => EquitySelectPage(name: "hole$num", cardList: cards),
        );
      },
      child: Row(
        children: cardBoxes,
      ),
    );
  }
}