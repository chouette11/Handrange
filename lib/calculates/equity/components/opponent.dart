import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:handrange/calculates/components/rangeList.dart';
import 'package:handrange/calculates/equity/components/holebox.dart';
import 'package:handrange/calculates/equity/models/equity_page_model.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';

class Opponent extends StatelessWidget {
  Opponent({Key? key, required this.num, required this.cardHole, required this.range}) : super(key: key);
  final int num;
  final List<String> cardHole;
  final List<Map<String, dynamic>> range;

  @override
  Widget build(BuildContext context) {
    final percent = context.select<EquityPageModel, double> ((EquityPageModel model) => model.oppPercent);
    return Consumer<EquityPageModel>(builder: (context, model, child) {
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
                    num: num,
                    cardHole: cardHole,
                  ),
                  Visibility(
                    visible: model.isRange,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                content: AlertRangeList(
                                  range: range,
                                ),
                              ),
                        );
                      },
                      child: HandRange(
                        children: range.map((e) =>
                            GridTile(
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
                      Text(
                        " ${(percent * 100).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            model.isRange = true;
                            model.notifyListeners();
                          },
                          child: Text("レンジ")
                      ),
                      ElevatedButton(
                          onPressed: () {
                            model.isRange = false;
                            model.notifyListeners();
                          },
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
    });
  }
}