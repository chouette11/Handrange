import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/widgets/ad_state.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

//selectCard
Container CardBox(int n, String m){
  return Container(
    color: n == 0 ? Colors.black26 : Colors.white,
    child: Container(
      width: 40,
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: bigCard(n, m),
    ),
  );
}

// ignore: non_constant_identifier_names
Column bigCard(int number, String selectedMark) {
  String returnName(int n) {
    if (n == 0) {
      return "";
    }
    else if (n == 13) {
      return "K";
    }
    else if (n == 12) {
      return "Q";
    }
    else if (n == 11) {
      return "J";
    }
    else if (n == 10) {
      return "T";
    }
    else if (n == 1) {
      return "A";
    }
    else{
      return "$n";
    }
  }
  String returnMark(String m) {
    if (m == "") {
      return "";
    }
    else if (m == "s") {
      return "♠";
    }
    else if (m == "c") {
      return "♣";
    }
    else if (m == "h") {
      return "♥";
    }
    else if (m == "d") {
      return "♦";
    }
    else {
      return "error";
    }
  }
  return Column(
    children: [
      Center(
        child: Text(
          returnName(number),
          style: TextStyle(fontSize: 23,fontFamily: "PTS",color: Colors.black38),
        ),
      ),
      Center(
        child: Text(
          returnMark(selectedMark),
          style: selectedMark == "♦" || selectedMark == "♥"  ? TextStyle(fontSize: 23,fontFamily: "PTS", color: Colors.redAccent) : TextStyle(fontSize: 23,fontFamily: "PTS", color: Colors.black38),
        ),
      ),
    ],
  );
}

Column smallCard(int number, String selectedMark){
  String returnText(int n) {
    if (n == 0) {
      return "";
    }
    else if (n == 13) {
      return "K";
    }
    else if (n == 12) {
      return "Q";
    }
    else if (n == 11) {
      return "J";
    }
    else if (n == 10) {
      return "T";
    }
    else if (n == 1) {
      return "A";
    }
    else{
      return "$n";
    }
  }
  String returnMark(String m) {
    if (m == "") {
      return "";
    }
    else if (m == "s") {
      return "♠";
    }
    else if (m == "c") {
      return "♣";
    }
    else if (m == "h") {
      return "♥";
    }
    else if (m == "d") {
      return "♦";
    }
    else{
      return "error";
    }
  }
  return Column(
    children: [
      Expanded(
        child: Text(
          returnText(number),
          style: TextStyle(color: Colors.black38),
        ),
      ),
      Expanded(
        child: Text(
          returnMark(selectedMark),
          style: selectedMark == "♦" || selectedMark == "♥"  ? TextStyle(fontFamily: "PTS", color: Colors.redAccent) : TextStyle(fontFamily: "PTS", color: Colors.black38) ,
        ),
      ),
    ],
  );
}

//AdState
String unitId(String AdunitId) {
  var isRelease = const bool.fromEnvironment('dart.vm.project');

  if (isRelease) {
    return AdunitId;
  } else {
    return "ca-app-pub-3940256099942544/6300978111";
  }
}

launchURL() async {
  const url = "https://twitter.com/chouette111";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not Launch $url';
  }
}
