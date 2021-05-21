import 'package:handrange/combination.dart';

List<List<Map<String, dynamic>>> getTFs(snapshot) {
  int i, j;
  List<List<Map<String, dynamic>>>inputTFs = [];
  for (j = 0; j < snapshot.data.length; j++) {
    String TFText = snapshot.data[j].text;
    List<Map<String, dynamic>> TF = CONBI.map((e) =>
    {
      "hand": e["hand"],
      "value": e["value"],
    }).toList();

    for (i = 0; i <= 168; i++) {
      String isTF = TFText[i];
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
    inputTFs.add(TF);
  }
  return inputTFs;
}

List <Map<String,dynamic>> getIds(snapshot) {
  List <Map<String,dynamic>> inputIds = [];
  int i;
  for(i = 0; i < snapshot.data.length; i++){
    int id = snapshot.data[i].id;
    String graphName = snapshot.data[i].name;
    int num = snapshot.data[i].count;
    Map <String,dynamic> ids_map = {};
    ids_map.addAll(
        <String,dynamic>{
          "id": id,
          "num":i,
          "name":graphName,
          "count": num
        }
    );
    inputIds.add(ids_map);
  }
  return inputIds;
}