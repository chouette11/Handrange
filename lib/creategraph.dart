import 'package:handrange/combination.dart';

List getTFs(graphs) {
  int i, j;
  List<List>inputTFs = [];
  for (j = 0; j < graphs.length; j++) {
    String TFText = graphs[j].text;
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

List getIds(graphs) {
  List <Map<String,dynamic>> inputIds = [];
  int i;
  for(i = 0; i < graphs.length; i++){
    int id = graphs[i].id;
    String graphName = graphs[i].name;
    int num = graphs[i].count;
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

