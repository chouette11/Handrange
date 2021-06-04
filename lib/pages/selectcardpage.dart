import 'package:flutter/material.dart';
import '../components/functions/elements.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../providers/light.dart';
import '../datas/combination.dart';
import '../providers/calculation.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handrange',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SelectPage(),
    );
  }
}

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BackButton(),
          ],
        ),
        Buttons(),
      ],
    );
  }
}

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () =>
        Navigator.pushNamed(context, '/calculate'),
      child: Text("戻る"),
    );
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
    return GridView.count(
      crossAxisCount: 13,
      mainAxisSpacing: 0.001,
      crossAxisSpacing: 0.001,
      childAspectRatio: 0.78,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: CARDS.map((e) =>
          GridTile(
            child: Button(num: e["num"], mark: e["mark"], card: e["card"]),
          ),
      ).toList(),
    );
  }
}

class Button extends StatelessWidget{
  Button( {Key? key,  required this.num, required this.mark,  required this.card }) : super(key: key);
  final int num;
  final String mark;
  final String card;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<Calculation>(builder: (context, model, child) {
        return GestureDetector(
          onTap: () => {
            if (model.num1 == 0) {
              model.num1 = num,
              model.mark1 = mark,
              model.card1 = card,
              Navigator.pushNamed(context, '/calculate'),
            }
            else if (model.num2 == 0 && model.card1 != card) {
              model.num2 = num,
              model.mark2 = mark,
              model.card2 = card,
              Navigator.pushNamed(context, '/calculate'),
            }
            else if (model.num3 == 0 && model.card1 != card && model.card2 != card) {
                model.num3 = num,
                model.mark3 = mark,
                model.card3 = card,
                Navigator.pushNamed(context, '/calculate'),
              }
              else if (model.num4 == 0 && model.card1 != card && model.card2 != card && model.card3 != card ) {
                  model.num4 = num,
                  model.mark4 = mark,
                  model.card4 = card,
                  Navigator.pushNamed(context, '/calculate'),
                }
                else if (model.num5 == 0 && model.card1 != card && model.card2 != card && model.card3 != card && model.card4 != card) {
                    model.num5 = num,
                    model.mark5 = mark,
                    model.card5 = card,
                    Navigator.pushNamed(context, '/calculate'),
                  }
                  else{
                      Navigator.pushNamed(context, '/calculate'),
                    },
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: smallCard(num, mark),
          ),
        );
      }),
    );
  }
}

