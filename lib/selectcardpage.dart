import 'package:flutter/material.dart';gi
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/combination.dart';
import 'calculation.dart';

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
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SelectCards(),
          );
      });
  }
}

class SelectCards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Buttons(),
            ],
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
        color: Colors.white,
        child: Consumer<Calculation>(builder: (context, model, child) {
          return
            GestureDetector(
                onTap: () =>{
                  if(model.num1 == null){
                    model.num1 = num,
                    model.mark1 = mark,
                    model.card1 = card,
                    Navigator.pushNamed(context, '/calculate'),
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
                    child: returnCards(num, mark)
                )
            );
        }),
      );
  }
}

Column returnCards(int number, String selectedMark){
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
        Expanded(child: Text(
            returnText(number)
        ),),
        Expanded(child: Text(
            returnMark(selectedMark)
        ))
      ],
    );
}