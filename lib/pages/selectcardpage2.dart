import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/datas/combination.dart';
import 'package:handrange/functions/elements.dart';
import 'package:handrange/providers/eqcalculation.dart';
import 'package:provider/provider.dart';

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
            ElevatedButton(onPressed: () =>
                Navigator.pushNamed(context, '/equity'),
              child: Text("戻る"),
            ),
          ],
        ),
        Buttons(),
      ],
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
      child: Consumer<EqCalculation>(builder: (context, model, child) {
        return GestureDetector(
          onTap: () => {
            if (model.num1 == 0) {
              model.num1 = num,
              model.mark1 = mark,
              model.card1 = card,
              Navigator.pushNamed(context, '/equity'),
            }
            else if (model.num2 == 0 && model.card1 != card) {
              model.num2 = num,
              model.mark2 = mark,
              model.card2 = card,
              Navigator.pushNamed(context, '/equity'),
            }
            else{
                Navigator.pushNamed(context, '/equity'),
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

