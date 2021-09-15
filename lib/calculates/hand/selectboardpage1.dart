import 'package:flutter/material.dart';
import '../../components/functions/elements.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../make/models/make_page_model.dart';
import '../../datas/combination.dart';
import 'models/calculation.dart';

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SelectCards(),
    );
  }
}

class SelectCards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Consumer<Calculation>(builder: (context, model, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text('クリア'),
                onPressed: () {
                  model.num1 = 0;
                  model.num2 = 0;
                  model.num3 = 0;
                  model.num4 = 0;
                  model.num5 = 0;
                  model.mark1 = "";
                  model.mark2 = "";
                  model.mark3 = "";
                  model.mark4 = "";
                  model.mark5 = "";
                  model.card1 = "";
                  model.card2 = "";
                  model.card3 = "";
                  model.card4 = "";
                  model.card5 = "";
                  model.onReset();
                  model.notifyListeners();
                },
              ),
              SizedBox(width: 5, height: 3),
              ElevatedButton(onPressed: () =>
                  Navigator.pop(context),
                child: Text("戻る"),
              ),
            ],
          ),
          Buttons(),
        ],
      );
    });
  }
}

class DeleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 60,
        height: 40,
        color: Colors.blueGrey,
        child: Center(
          child: Text("削除"),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Consumer<Calculation>(builder: (context, model, child) {
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
  Button( {Key? key,  required this.num, required this.mark,  required this.card, required this.isColor }) : super(key: key);
  final int num;
  final String mark;
  final String card;
  final bool isColor;
  @override
  Widget build(BuildContext context) {
    return Consumer<Calculation>(builder: (context, model, child) {
      return Container(
        color: Colors.white,
        child: Container(
          color: isColor ? Colors.white70 : Colors.black38,
          child: GestureDetector(
            onTap: () => {
              if (model.num1 == 0) {
                model.num1 = num,
                model.mark1 = mark,
                model.card1 = card,
                model.onTapped(card),
                model.notifyListeners(),
              }
              else if (model.num2 == 0 && model.card1 != card) {
                model.num2 = num,
                model.mark2 = mark,
                model.card2 = card,
                model.onTapped(card),
                model.notifyListeners(),
              }
              else if (model.num3 == 0 && model.card1 != card && model.card2 != card) {
                  model.num3 = num,
                  model.mark3 = mark,
                  model.card3 = card,
                  model.onTapped(card),
                  model.notifyListeners(),
                }
                else if (model.num4 == 0 && model.card1 != card && model.card2 != card && model.card3 != card ) {
                    model.num4 = num,
                    model.mark4 = mark,
                    model.card4 = card,
                    model.onTapped(card),
                    model.notifyListeners(),
                  }
                  else if (model.num5 == 0 && model.card1 != card && model.card2 != card && model.card3 != card && model.card4 != card) {
                      model.num5 = num,
                      model.mark5 = mark,
                      model.card5 = card,
                      model.onTapped(card),
                      model.notifyListeners(),
                      Navigator.pop(context),
                    }
                    else{
                        Navigator.pop(context),
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

