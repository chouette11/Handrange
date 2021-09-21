import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/rangeList.dart';
import 'package:handrange/calculates/equity/components/holebox.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';

class Player extends StatelessWidget {
  Player({Key? key, required this.num, required this.cardHole, required this.range}) : super(key: key);
  final int num;
  final List<String> cardHole;
  final List<Map<String, dynamic>> range;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("プレイヤー$num")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: RangeList(
                        range: range,
                        mainAxisSpacing: 0.5,
                        crossAxisSpacing: 1,
                        childAspectRatio: 0.75,
                      ),
                    ),
                  );
                },
                child: Text("レンジ")
            ),
            HandRange(
              children: range.map((e) => GridTile(
                child: CustomTapBox(
                  isSelected: e["isSelected"],
                ),
              )).toList(),
              size: 4,
            ),
            HoleBox(num: num, cardHole: cardHole),
          ],
        ),
      ],
    );
  }
}