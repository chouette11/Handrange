import 'package:flutter/material.dart';
import '../../components/functions/elements.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'models/hand_page_model.dart';

class HandSelectPage extends StatelessWidget {
  HandSelectPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: () =>
              Navigator.pop(context),
            child: Text("戻る"),
          ),
          Consumer<HandPageModel>(builder: (context, model, child) {
            return GridView.count(
              crossAxisCount: 13,
              mainAxisSpacing: 0.001,
              crossAxisSpacing: 0.001,
              childAspectRatio: 0.78,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: model.cards.map((e) =>
                  GridTile(
                    child: SelectButton(num: e["num"],
                        mark: e["mark"],
                        card: e["card"],
                        isColor: e["isColor"]),
                  ),
              ).toList(),
            );
          }),
        ],
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
    return Consumer<HandPageModel>(builder: (context, model, child) {
      return Container(
        color: Colors.white,
        child: Container(
          color: isColor ? Colors.white70 : Colors.black38,
          child: GestureDetector(
            onTap: () => {
              if (isColor == true) {
                model.addBoard(num, mark, card),
                if (model.board.length == 5) {
                  Navigator.pop(context),
                }
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
