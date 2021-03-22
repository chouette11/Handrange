import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/light.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handrange',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: ChangeNotifierProvider<Pockets>(
        create: (_) => Pockets(),
        child: MyHomePage() ,
      )
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Handrange'),
        ),
        body:Consumer<Pockets>(builder: (context, model, child) {
          return
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Keyboard(),
                TextField(),
                RaisedButton(
                    child: Text('button'),
                    onPressed: () {
                      model.onPowerSwitch();
                    }),
                Text(
                  '${model.active}'
                ),
              ],
            );
        }
        )
    );
  }
}


//=============================================================================
// 表示
class TextField extends StatefulWidget {
  @override
  _TextFiledState createState() => _TextFiledState();
  static int _expression;
}
class _TextFiledState extends State<TextField> {
  int _expression = 0;

  static final controller = StreamController<int>();
  @override
  void initState() {
    controller.stream.listen((event) => _UpdateText(event));
  }

  void _UpdateText(int letter){
    setState(() {
      _expression += letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    double VPIP = (_expression / 1326) * 100;

    return
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${VPIP.toStringAsFixed(3)}%',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      );
  }

}

class View extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      child:Text(
        '${TextField._expression}',
        style: TextStyle(
          fontSize: 64.0,
        ),
      ),
    );
  }
}




//==============================================================================
// キーボード
class Keyboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screensizewidth = MediaQuery.of(context).size.width;
    return Container(
      width: screensizewidth,
      height: screensizewidth,
      color: Colors.white,
      child: GridView.count(
          crossAxisCount: 13,
          mainAxisSpacing: 0.001,
          crossAxisSpacing: 0.001,
          children: CONBI.map((e) => GridTile(
            child: Tapbox(hand: e["hand"], value: e["value"],),
          ),
          ).toList()
      ),
    );
  }
}

//　キーボタン
class Tapbox extends StatefulWidget {
  Tapbox( {Key key, this.hand, this.value }) : super(key: key);
  String hand; int value;
  @override
  _TapboxState createState() => _TapboxState();
}

class _TapboxState extends State<Tapbox> {

  bool active = false;

  void _changetrue() async {
    setState(() {
      return
        active = true;
    });
    if (active == false)
      _TextFiledState.controller.sink.add(widget.value);
    else
      _TextFiledState.controller.sink.add(-widget.value);
  }

  void _changefalse() async{
    setState(() {
      return
        active = false;
    });
}


  Widget build(BuildContext context) {
    return
    Container(
    child:Consumer<Pockets>(builder: (context, model, child) {
        return
          GestureDetector(
            onTap: () {
              if (model.active == true) {
                model.active = false;
                _changefalse();
              }
              else if (model.active == false && active == true) {
                _changefalse();
              }
              else if (model.active == false && active == false) {
                _changetrue();
              }
            }
            ,

            child: Consumer<Pockets>(builder: (context, model, child) {
              if (active == true || model.active == true) {
                return
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.white),
                        color: Colors.green.shade600
                    ),
                    child: Center(
                      child: Text(
                          widget.hand
                      ),
                    ),
                  );
              }
              else {
                return
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.white),
                        color: Colors.green.shade50
                    ),
                    child: Center(
                      child: Text(
                          widget.hand
                      ),
                    ),
                  );
              }
            }
            ),
          );
      }
    )
    );
  }
}

// child: (() {
//   if (widget.hand == 'AA') {
//     return Text('1');
//   } else {
//     return Text('2');
//   }
// })(),
