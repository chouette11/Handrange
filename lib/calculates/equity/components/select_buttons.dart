import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/functions/elements.dart';
import '../models/equity_page_model.dart';
import 'package:provider/provider.dart';

class Buttons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<EquityPageModel>(builder: (context, model, child) {
      return GridView.count(
        crossAxisCount: 13,
        mainAxisSpacing: 0.001,
        crossAxisSpacing: 0.001,
        childAspectRatio: 0.78,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: model.cards.map((e) =>
            GridTile(
              child: Button(num: e["num"], mark: e["mark"], card: e["card"], isColor: e["isColor"]),
            ),
        ).toList(),
      );
    });
  }
}

class Button extends StatelessWidget{
  Button({Key? key,  required this.num, required this.mark,  required this.card, required this.isColor }) : super(key: key);
  final int num;
  final String mark;
  final String card;
  final bool isColor;
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<String>(context);
    return Consumer<EquityPageModel>(builder: (context, model, child) {
      return Container(
        color: Colors.white,
        child: Container(
          color: isColor ? Colors.white70 : Colors.black38,
          child: GestureDetector(
            onTap: () => {
              if (isColor == true) {
                if (name == "board") {
                  model.addBoard(num, mark, card),
                  if (model.board.length == 5) {
                    Navigator.pop(context),
                  }
                } else if (name == "hole1") {
                  model.addHole1(num, mark, card),
                  if (model.board.length == 2) {
                    Navigator.pop(context),
                  }
                } else if (name == "hole2") {
                  model.addHole2(num, mark, card),
                  if (model.board.length == 2) {
                    Navigator.pop(context),
                  }
                },
              },
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: smallCard(num, mark),
            ),
          ),
        ),
      );
    });
  }
}

