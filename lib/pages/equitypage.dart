import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/drawer.dart';
import 'package:handrange/functions/elements.dart';
import 'package:handrange/pages/calculatepage.dart';
import 'package:handrange/pages/selectcardpage2.dart';
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
        home: EquityPage()
    );
  }
}

class EquityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('エクイティ計算'),
        ),
        drawer: returnDrawer(context),
        body:Calculate()
    );
  }
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("プレイヤー１")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: SaveGraphs(),
                      ),
                    );
                  },
                  child: Text("レンジ")
              ),
              CardBoxes(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("プレイヤー１")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: Text("レンジ")
              ),
              CardBoxes(),
            ],
          ),
        ],
      ),
    );
  }
}

class CardBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<EqCalculation>(builder: (context, model, child) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => SelectPage(),
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CardBox(model.num1, model.mark1),
                  CardBox(model.num2, model.mark2),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}