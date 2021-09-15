import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/functions/elements.dart';

Container cardBox(int? number, String? mark){
  return Container(
    color: number == null || number == 0 ? Colors.black26 : Colors.white,
    child: Container(
        width: 40,
        height: 65,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                returnNumber(number),
                style: TextStyle(fontSize: 23,fontFamily: "PTS",color: Colors.grey[800]),
              ),
            ),
            Center(
              child: Text(
                returnMark(mark),
                style: mark == "♠" || mark == "♣" ?
                TextStyle(fontSize: 23,fontFamily: "PTS", color: Colors.grey[700]) :
                TextStyle(fontSize: 23,fontFamily: "PTS", color: Colors.red[900]),
              ),
            ),
          ],
        ),
    ),
  );
}