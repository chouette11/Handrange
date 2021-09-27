import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/functions/elements.dart';

Container cardBox(int? number, String? mark){
  return Container(
    width: 48,
    height: 72,
    decoration: BoxDecoration(
      color: number == null || number == 0 ? Colors.black12 : Colors.white,
      border: number == null || number == 0 ? null : Border.all(color: Colors.black54, width: 1.6),
      borderRadius: BorderRadius.circular(4)
    ),
    child: Column(
      children: [
        Center(
          child: Text(
            returnNumber(number),
            style: TextStyle(fontSize: 24,fontFamily: "PTS",color: Colors.grey[800]),
          ),
        ),
        Center(
          child: Text(
            returnMark(mark),
            style: mark == "♠" || mark == "♣" ?
            TextStyle(fontSize: 24,fontFamily: "PTS", color: Colors.grey[700]) :
            TextStyle(fontSize: 24,fontFamily: "PTS", color: Colors.red[900]),
          ),
        ),
      ],
    ),
  );
}