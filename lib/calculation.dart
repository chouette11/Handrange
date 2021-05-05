import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/save.dart';
import 'package:handrange/combination.dart';
import 'package:flutter/material.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/sql.dart';

class Calculation extends ChangeNotifier{
  int num1;
  int num2;
  int num3;
  int num4;
  int num5;
  String mark1;
  String mark2;
  String mark3;
  String mark4;
  String mark5;

  handJudge(){
    List<int> numbers = [];
    numbers.add(num1);numbers.add(num2);numbers.add(num3);numbers.add(num4);numbers.add(num5);
    List<String> marks = [];
    marks.add(mark1);marks.add(mark2);marks.add(mark3);marks.add(mark4);marks.add(mark5);
    int i;
    if(marks.every((String mark) => mark == RegExp(r"[s,c,h,d]"))){
      if(numbers.contains(13) && numbers.contains(12) && numbers.contains(11) && numbers.contains(10) && numbers.contains(1)){
        print("RoyalStraightFlush");
      }
      for(i = 1; i <= 8; i++){
        if(numbers.contains(i) && numbers.contains(i + 1) && numbers.contains(i + 2) && numbers.contains(i + 3) && numbers.contains(i + 4)){
          print("StraightFlush");
        }
      }
    }
    else if(numbers.toString().contains(RegExp(r"([1-13])\1{3}")) && numbers.toString().contains(RegExp(r""))){
      print("FullHouse");
    }
    else if(marks.every((mark) => mark == RegExp(r"."))){
      print("Flush");
    }
    for(i = 1; i <= 8; i++){
      if(numbers.contains(i) && numbers.contains(i + 1) && numbers.contains(i + 2) && numbers.contains(i + 3) && numbers.contains(i + 4)){
        print("Straight");
      }
    }
    if(numbers.toString().contains(RegExp(r"([1-13])\1{3}"))){
      print("ThreeCards");
    }
    else if (numbers.toString().contains(RegExp(r"([1-13])\1{2}"))){
      print("TwoPair");
    }
    else{
      print("は？");
    }
  }
}