import 'package:flutter/material.dart';
import 'models/equity_page_model.dart';
import '../../components/functions/elements.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../make/models/make_page_model.dart';
import '../../datas/combination.dart';
import '../hand/models/calculation.dart';
import 'components/select_buttons.dart';

class SelectPageEq extends StatelessWidget {
  SelectPageEq({Key? key,  required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Provider<String>.value(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () =>
                    Navigator.pop(context),
                  child: Text("戻る"),
                ),
              ],
            ),
            Buttons(),
          ],
        ),
        value: name,
      ),
    );
  }
}

