import 'package:handrange/data/combination.dart';

getRangeFromSQL(int id, List<Map<String, dynamic>> range, dynamic sql) async {
  String tfText = sql[id].text;
  int i;
  for (i = 0; i <= 168; i++) {
    String isTF = tfText[i];
    if (isTF == "T") {
      range[i].removeWhere((key, value) => value == false || value == true);
      range[i].addAll(
          <String,bool>{
            "isSelected": true,
          }
      );
    }
    else if (isTF == "F") {
      range[i].removeWhere((key, value) => value == false || value == true);
      range[i].addAll(
          <String,dynamic>{
            "isSelected": false,
          }
      );
    }
  }
}

List<Map<String, dynamic>> getIsSelected(String tfText) {
  List<Map<String, dynamic>> isSelected = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
  }).toList();

  int i;
  for (i = 0; i <= 168; i++) {
    if (tfText[i] == "T") {
      isSelected[i].addAll(
          <String, bool>{
            "isSelected": true,
          }
      );
    }
    else if (tfText[i] == "F") {
      isSelected[i].addAll(
          <String, bool>{
            "isSelected": false,
          }
      );
    }
  }
  return isSelected;
}

List <Map<String,dynamic>> getRangeListFromSQL(snapshot) {
  List <Map<String,dynamic>> ranges = [];

  for (int i = 0; i < snapshot.data.length; i++) {
    Map <String,dynamic> rangesMap = {};

    rangesMap.addAll(
        <String,dynamic>{
          "id": snapshot.data[i].id,
          "num": i,
          "text": snapshot.data[i].text,
          "name": snapshot.data[i].name,
          "count": snapshot.data[i].count,
        }
    );
    ranges.add(rangesMap);
  }
  return ranges;
}

List<Map<String,String>> labelList = [
  {
    "num":"A"
  },{
    "num":"K"
  },{
    "num":"Q"
  },{
    "num":"J"
  },{
    "num":"T"
  },{
    "num":"9"
  },{
    "num":"8"
  },{
    "num":"7"
  },{
    "num":"6"
  },{
    "num":"5"
  },{
    "num":"4"
  },{
    "num":"3"
  },{
    "num":"2"
  },
];

List<Map<String,String>> ColumnLabelList = [
  {
    "num":""
  }, {
    "num":"A"
  },{
    "num":"K"
  },{
    "num":"Q"
  },{
    "num":"J"
  },{
    "num":"T"
  },{
    "num":"9"
  },{
    "num":"8"
  },{
    "num":"7"
  },{
    "num":"6"
  },{
    "num":"5"
  },{
    "num":"4"
  },{
    "num":"3"
  },{
    "num":"2"
  },
];