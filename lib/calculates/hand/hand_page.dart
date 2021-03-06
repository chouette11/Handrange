import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/board_boxes.dart';
import 'package:handrange/calculates/components/range_list.dart';
import 'package:handrange/calculates/components/bar_chart.dart';
import 'package:handrange/components/drawer.dart';
import 'package:handrange/components/gridview.dart';
import 'package:handrange/components/tapbox.dart';
import 'models/hand_page_model.dart';
import '../../components/drawer.dart';
import '../../ad/popad_page.dart';
import 'hand_select_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('役計算'),
      ),
      drawer: returnDrawer(context),
      body: Consumer<HandPageModel>(builder: (context, model, child) {
        return ListView(
          children: [
            HandRange(
              children: model.status.map((e) => GridTile(
                child: CustomTapBox(
                  name: e["hand"],
                  isSelected: e["isSelected"],
                ),
              )).toList(),
              size: 1,
            ),
            BoardBoxes(
              boardCard: model.boardCard,
              selectPage: HandSelectPage(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text('クリア'),
                    onPressed: () {
                      model.boardCard.clear();
                      model.onReset();
                      model.notifyListeners();
                    },
                  ),
                  SizedBox(width: 8),
                  RaisedButton(
                    child: Text('レンジ読み込み'),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: AlertRangeList(
                            range: model.status,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    child: Text('計算'),
                    onPressed: () async {
                      if (model.boardCard.length <= 2) {
                        showDialog(context: context,
                          builder: (_) => SimpleDialog(
                            title:Text("エラー"),
                            children: <Widget>[
                              SimpleDialogOption(
                                child: Text('ボードのカードを３枚以上選択してください'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      else {
                        model.onVisible();
                        model.calculate(model.status, model.boardCard);
                      }
                    },
                  ),
                ],
              ),
            ),
            Visibility(
                visible: model.isVisible,
                child: BarChart(comboList:model.comboList.reversed.toList())
            ),
          ],
        );
      }),
    );
  }
}
