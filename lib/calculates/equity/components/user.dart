import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:handrange/calculates/equity/components/holebox.dart';
import 'package:handrange/calculates/equity/models/equity_page_model.dart';

class User extends StatelessWidget {
  User({Key? key, required this.num, required this.cardHole}) : super(key: key);
  final int num;
  final List<String> cardHole;

  @override
  Widget build(BuildContext context) {
    final percent = context.select<EquityPageModel, double> ((EquityPageModel model) => model.heroPercent);
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 16),
            child: HoleBox(
              num: num,
              cardHole: cardHole,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "あなた",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16),
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
            ],
          ),
        ],
      ),
    );
  }
}