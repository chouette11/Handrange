import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/board_boxes.dart';
import 'package:handrange/calculates/equity/components/player.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'models/calculation_model.dart';
import 'equity_select_page.dart';
import 'models/equity_page_model.dart';
import 'package:provider/provider.dart';

class EquityPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('エクイティ計算'),
      ),
      drawer: returnDrawer(context),
      body: Consumer<EquityPageModel>(builder: (context, model, child) {
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: BoardBoxes(
                boardCard: model.boardCard,
                selectPage: EquitySelectPage(cardList: model.cards, name: 'board'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  child: Text('クリア'),
                  onPressed: () => model.onClear(),
                ),
                RaisedButton(
                    child: Text('計算'),
                    onPressed: () {
                      print('${winPlayer(handJudge(addInt(model.numHole1, model.board), addHand(model.markHole1, model.boardMark), addHand(model.cardHole1, model.boardCard)),
                          handJudge(addInt(model.numHole2, model.board), addHand(model.markHole2, model.boardMark), addHand(model.cardHole2, model.boardCard)))}');
                    }
                )
              ],
            ),
            Expanded(
              flex: 2,
              child: Player(num: 1, cardHole: model.cardHole1, range: model.status1),
            ),
            Expanded(
              flex: 2,
              child: Player(num: 2, cardHole: model.cardHole2, range: model.status2),
            ),
          ],
        );
      }),
    );
  }
}

