import 'package:flutter/cupertino.dart';
import '../models/make_page_model.dart';
import 'package:provider/provider.dart';

class VPIPField extends StatefulWidget {
  @override
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<VPIPField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      child:Consumer<MakePageModel>(builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 13),
                        child: Text(
                          'VPIP: ${((model.count / 1326) * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
