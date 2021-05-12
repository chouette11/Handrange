import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/combination.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Handrange',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: CalculatePage()
    );
  }
}

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
          child: Consumer<Light>(builder: (context, model, child) {
            return
              Scaffold(
                appBar: AppBar(
                  title: Text('Handrange'),
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Text(
                          'Drawer Header',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.graphic_eq_sharp),
                        title: Text('Graphs'),
                        onTap: () async {
                          await model.createGraphs();
                          await Navigator.pushNamed(context, '/save');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.file_copy),
                        title: Text('Calculate'),
                        onTap: () async {
                          await model.createGraphs();
                          await Navigator.pushNamed(context, '/calculate');
                        },
                      ),
                    ],
                  ),
                ),
                body: Calculate(),
              );
          })
      );
  }
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Consumer<Calculation>(builder: (context, model, child) {
          return
            ListView(
              children: [
                Display(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("${model.num1}${model.mark1}"),
                    Text("${model.num2}${model.mark2}"),
                    Text("${model.num3}${model.mark3}"),
                    Text("${model.num4}${model.mark4}"),
                    Text("${model.num5}${model.mark5}"),
                  ],
                ),
                Buttons(),
                RaisedButton(
                    child: Text('グラフ判定'),
                    onPressed: () {
                      model.graphJudge();
                    }),
                RaisedButton(
                    child: Text('クリア'),
                    onPressed: () {
                      model.num1 = null;
                      model.num2 = null;
                      model.num3 = null;
                      model.num4 = null;
                      model.num5 = null;
                      model.mark1 = null;
                      model.mark2 = null;
                      model.mark3 = null;
                      model.mark4 = null;
                      model.mark5 = null;
                    }),
                RaisedButton(
                    child: Text('読み込み'),
                    onPressed: () {
                      model.onGet(0);
                    }),
                Result(),
              ],
            );
        }),
      );
  }
}

class Display extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child: Consumer<Calculation>(
        builder: (context, model, child) {
          return GridView.count(
              crossAxisCount: 13,
              mainAxisSpacing: 0.001,
              crossAxisSpacing: 0.001,
              children: model.status.map((e) => GridTile(
                child: TapBox(hand: e["hand"], isSelected: e["isSelected"]),
              ),
              ).toList()
          );
        },
      ),
    );
  }
}

class TapBox extends StatelessWidget {
  TapBox( {Key key, this.hand, this.isSelected }) : super(key: key);
  String hand;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<Light>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          model.onTapped(hand);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          ),
          child: Center(
            child: Text(
              hand,
            ),
          ),
        ),
      );
    });
  }
}

class CardBoxes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Calculation>(builder: (context, model, child) {
        return
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  returnCard(model.num1, model.mark1),
                  returnCard(model.num2, model.mark2),
                  returnCard(model.num3, model.mark3),
                  returnCard(model.num4, model.mark4),
                  returnCard(model.num5, model.mark5),
                ],
              )
          );
      });
  }
}

class Buttons extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Consumer<Light>(builder: (context, model, child) {
          return
            GridView.count(
                crossAxisCount: 13,
                mainAxisSpacing: 0.001,
                crossAxisSpacing: 0.001,
                childAspectRatio: 0.78,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: CARDS.map((e) => GridTile(
                  child: Button(num: e["num"], mark: e["mark"], card: e["card"]),
                ),
                ).toList()
            );
        }),
      );
  }
}

class Button extends StatelessWidget{
  Button( {Key key,  this.num, this.mark,  this.card }) : super(key: key);
  int num;
  String mark;
  String card;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Consumer<Calculation>(builder: (context, model, child) {
          return
            GestureDetector(
                onTap: () =>{
                  if(model.num1 == null){
                    model.num1 = num,
                    model.mark1 = mark,
                    model.card1 = card,
                    Navigator.pushNamed(context, '/calculate')
                  }
                  else if(model.num2 == null && model.card1 != card){
                    model.num2 = num,
                    model.mark2 = mark,
                    model.card2 = card,
                    Navigator.pushNamed(context, '/calculate')
                  }
                  else if(model.num3 == null && model.card1 != card && model.card2 != card){
                      model.num3 = num,
                      model.mark3 = mark,
                      model.card3 = card,
                      Navigator.pushNamed(context, '/calculate')
                    }
                    else if(model.num4 == null && model.card1 != card && model.card2 != card && model.card3 != card ){
                        model.num4 = num,
                        model.mark4 = mark,
                        model.card4 = card,
                        Navigator.pushNamed(context, '/calculate')
                      }
                      else if(model.num5 == null && model.card1 != card && model.card2 != card && model.card3 != card && model.card4 != card){
                          model.num5 = num,
                          model.mark5 = mark,
                          model.card5 = card,
                          Navigator.pushNamed(context, '/calculate')
                        }
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: returnCard(num, mark)
                )
            );
        }),
      );
  }
}

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child:Consumer<Calculation>(builder: (context, model, child) {
          return
            Column(
              children: [
                Text("Royal combo:${model.royalStraightFlash} ${(model.royalStraightFlash / model.sum) * 100}%"),
                Text("StraightFlush combo:${model.straightFlush} ${(model.straightFlush / model.sum) * 100}%"),
                Text("FourCards combo:${model.fourCards} ${(model.fourCards / model.sum) * 100}%"),
                Text("FullHouse combo:${model.fullHouse} ${(model.fullHouse / model.sum) * 100}%"),
                Text("Flush combo:${model.flush} ${(model.flush / model.sum) * 100}%"),
                Text("Straight combo:${model.straight} ${(model.straight / model.sum) * 100}%"),
                Text("ThreeCards combo:${model.threeCards} ${(model.threeCards / model.sum) * 100}%"),
                Text("TwoPair combo:${model.twoPair} ${(model.twoPair / model.sum) * 100}%"),
                Text("OnePair combo:${model.onePair} ${(model.onePair / model.sum) * 100}%"),
              ],
            );
        }),
      );

  }
}

Column returnCard(int number, String selectedMark){
  String returnText(int n) {
    if(n == null){
      return "";
    }
    else if(n == 13){
      return "K";
    }
    else if(n == 12) {
      return "Q";
    }
    else if(n == 11) {
      return "J";
    }
    else if(n == 10){
      return "T";
    }
    else{
      return "${n}";
    }
  }
  String returnMark(String m){
    if(m == null){
      return "";
    }
    else if(m == "s"){
      return "♠";
    }
    else if(m == "c"){
      return "♣";
    }
    else if(m == "h"){
      return "♥";
    }
    else if(m == "d"){
      return "♦";
    }
  }
  return
    Column(
      children: [
        Text(
            returnText(number)
        ),
        Text(
            returnMark(selectedMark)
        )
      ],
    );
}
