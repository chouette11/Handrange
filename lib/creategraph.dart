import 'package:handrange/combination.dart';

List<Map<String, dynamic>> getTFs(String tfText,) {
  int i;
    List<Map<String, dynamic>> TF = CONBI.map((e) =>
    {
      "hand": e["hand"],
      "value": e["value"],
    }).toList();

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
  List <Map<String,dynamic>> inputIds = [];
  int i;
  for(i = 0; i < snapshot.data.length; i++){
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
    inputIds.add(ids_map);
  }
  return inputIds;
}