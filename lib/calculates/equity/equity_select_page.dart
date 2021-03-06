import 'package:flutter/material.dart';
import 'package:handrange/components/functions/elements.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'models/equity_page_model.dart';

class EquitySelectPage extends StatelessWidget {
  EquitySelectPage({Key? key,  required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Provider<String>.value(
        child: Consumer<EquityPageModel>(builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (name == "hole1") {
                        model.onIndivClear(model.cardHole1);
                      } else if (name == "hole2") {
                        model.onIndivClear(model.cardHole2);
                      } else if (name == "board") {
                        model.onIndivClear(model.boardCard);
                      }
                    },
                    child: Text("クリア"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("戻る"),
                  ),
                  SizedBox(width: 4),
                ],
              ),
              GridView.count(
                crossAxisCount: 13,
                mainAxisSpacing: 0.001,
                crossAxisSpacing: 0.001,
                childAspectRatio: 0.78,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: model.cards.map((e) =>
                    GridTile(
                      child: SelectButton(num: e["num"], mark: e["mark"], card: e["card"], isColor: e["isColor"]),
                    ),
                ).toList(),
              ),
            ],
          );
        }),
        value: name,
      ),
    );
  }
}

class SelectButton extends StatelessWidget{
  SelectButton({Key? key,  required this.num, required this.mark,  required this.card, required this.isColor }) : super(key: key);
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
                  if (model.boardCard.length < 5) {
                    model.addBoard(num, mark, card),
                    if (model.boardCard.length == 5) {Navigator.pop(context)},
                  } else {
                    Navigator.pop(context),
                  },
                } else if (name == "hole1") {
                  if (model.cardHole1.length < 2) {
                    model.addHole1(num, mark, card),
                    if (model.cardHole1.length == 2) {Navigator.pop(context)},
                  } else {
                    Navigator.pop(context),
                  },
                } else if (name == "hole2") {
                  if (model.cardHole2.length < 2) {
                    model.addHole2(num, mark, card),
                    if (model.cardHole2.length == 2) {Navigator.pop(context)},
                  } else {
                    Navigator.pop(context),
                  },
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

