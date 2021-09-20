import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/board_boxes.dart';
import 'package:handrange/calculates/components/rangeList.dart';
import 'package:handrange/components/widgets/bar_chart.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';
import 'models/hand_page_model.dart';
import '../../components/widgets/drawer.dart';
import '../../ad/popad_page.dart';
import 'hand_select_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class CalculatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('計算'),
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
              selectPage: HandSelectPage(cardList: model.cards),
            ),
            RaisedButton(
              child: Text('レンジ読み込み'),
              onPressed: () async {
                await model.createComboList();
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: RangeList(range: model.status),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('計算'),
              onPressed: () async {
                if (model.boardCard.length == 2) {
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
                  showDialog(
                    context: context,
                    builder: (_) => PopAdPage(),
                  );
                  model.graphJudge();
                  model.createComboList();
                }
              },
            ),
            Visibility(
                visible: model.isVisible,
                child: BarChart(comboList:model.comboList, onePairList: model.onePairList,)
            ),
          ],
        );
      }),
    );
  }
}
