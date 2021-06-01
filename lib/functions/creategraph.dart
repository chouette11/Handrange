import '../datas/combination.dart';

List<Map<String, dynamic>> getTFs(String tfText,) {
  List<Map<String, dynamic>> TF = CONBI.map((e) => {
    "hand": e["hand"],
    "value": e["value"],
  }).toList();

  int i;
  for (i = 0; i <= 168; i++) {
    String isTF = tfText[i];
    if (isTF == "T") {
      TF[i].addAll(
          <String, bool>{
            "isSelected": true,
          }
      );
    }
    else if (isTF == "F") {
      TF[i].addAll(
          <String, bool>{
            "isSelected": false,
          }
      );
    }
  }
  return TF;
}

List <Map<String,dynamic>> getIds(snapshot) {
  List <Map<String,dynamic>> Ids = [];

  int i;
  for (i = 0; i < snapshot.data.length; i++) {
    int id = snapshot.data[i].id;
    String text = snapshot.data[i].text;
    String graphName = snapshot.data[i].name;
    int count = snapshot.data[i].count;
    Map <String,dynamic> ids_map = {};

    ids_map.addAll(
        <String,dynamic>{
          "id": id,
          "num":i,
          "text":text,
          "name":graphName,
          "count": count
        }
    );
    Ids.add(ids_map);
  }
  return Ids;
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