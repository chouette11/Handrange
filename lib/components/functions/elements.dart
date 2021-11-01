import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String returnNumber(int? n) {
  if (n == null) {
    return "";
  } else if (n == 0) {
    return "";
  } else if (n == 13) {
    return "K";
  } else if (n == 12) {
    return "Q";
  } else if (n == 11) {
    return "J";
  } else if (n == 10) {
    return "T";
  } else if (n == 14) {
    return "A";
  } else if (n == 1) {
    return "A";
  } else {
    return "$n";
  }
}

String returnMark(String? m) {
  if (m == null) {
    return "";
  } else if (m == "") {
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

//selectCard


Column smallCard(int number, String selectedMark){
  return Column(
    children: [
      Expanded(child: Text(returnNumber(number))),
      Expanded(
        child: Text(returnMark(selectedMark),
          style: selectedMark == "♠" || selectedMark == "♣" ?
          TextStyle(color: Colors.grey[700]) :
          TextStyle(color: Colors.red[900]),
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

int aceTo14(int num) {
  if (num == 1) {
    return 14;
  } else {
    return num;
  }
}