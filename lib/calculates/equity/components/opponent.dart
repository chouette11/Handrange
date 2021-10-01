import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/rangeList.dart';
import 'package:handrange/calculates/equity/components/holebox.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';

class Opponent extends StatefulWidget {
  Opponent({Key? key, required this.num, required this.cardHole, required this.range}) : super(key: key);
  final int num;
  final List<String> cardHole;
  final List<Map<String, dynamic>> range;

  @override
  _OpponentState createState() => _OpponentState();
}

class _OpponentState extends State<Opponent> {
  var isRangeShow = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, right: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 16),
            child: Stack(
              children: [
                HoleBox(
                  num: widget.num,
                  cardHole: widget.cardHole,
                ),
                Visibility(
                  visible: isRangeShow,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: RangeList(
                            range: widget.range,
                            margin: EdgeInsets.only(top: 2, right: 2.5, left: 2.5),
                            mainAxisSpacing: 0.5,
                            crossAxisSpacing: 1,
                            childAspectRatio: 0.75,
                          ),
                        ),
                      );
                    },
                    child: HandRange(
                      children: widget.range.map((e) => GridTile(
                        child: CustomTapBox(
                          isSelected: e["isSelected"],
                        ),
                      )).toList(),
                      size: 3.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "相手",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "勝率",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text("0.00%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => setState(() => isRangeShow = true),
                        child: Text("レンジ")
                    ),
                    ElevatedButton(
                        onPressed: () => setState(() => isRangeShow = false),
                        child: Text("ハンド")
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}