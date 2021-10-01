import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/equity/components/holebox.dart';

class User extends StatelessWidget {
  User({Key? key, required this.num, required this.cardHole, required this.range}) : super(key: key);
  final int num;
  final List<String> cardHole;
  final List<Map<String, dynamic>> range;

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "あなた",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}