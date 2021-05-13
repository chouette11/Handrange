import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:handrange/selectcardpage.dart';
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
                CardBoxes(),
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

  Container returnContainer(int n, String m){
    return
      Container(
        color: n == null || m == null ? Colors.black26 : Colors.white,
        child: Container(
          width: 40,
          height: 65,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: returnCard(n, m),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<Calculation>(builder: (context, model, child) {
        return
          GestureDetector(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (_) => SelectPage()
              );

            },
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    returnContainer(model.num1, model.mark1),
                    returnContainer(model.num2, model.mark2),
                    returnContainer(model.num3, model.mark3),
                    returnContainer(model.num4, model.mark4),
                    returnContainer(model.num5, model.mark5),
                  ],
                )
            ),
          );
      });
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
        Center(
          child: Text(
            returnText(number),
            style: TextStyle(fontSize: 23,fontFamily: "PTS"),
          ),
        ),
        Center(
            child: Text(
              returnMark(selectedMark),
              style: TextStyle(fontSize: 23,fontFamily: "PTS"),
            )
        ),
      ],
    );
}
