import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/calculates/components/board_boxes.dart';
import 'package:handrange/calculates/equity/components/opponent.dart';
import 'package:handrange/calculates/equity/components/user.dart';
import 'package:handrange/components/drawer.dart';
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
            Container(
              child: BoardBoxes(
                boardCard: model.boardCard,
                selectPage: EquitySelectPage(name: 'board'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    child: Text('クリア'),
                    onPressed: () => model.onClear(),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    child: Text('計算'),
                    onPressed: () => model.equity(context),
                  ),
                ],
              ),
            ),
            User(num: 1, cardHole: model.cardHole1),
            Opponent(num: 2, cardHole: model.cardHole2, range: model.status1),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BottomAd(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

