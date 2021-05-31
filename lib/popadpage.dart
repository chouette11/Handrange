import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/light.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';
import 'calculation.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handrange',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: PopAdPage(),
    );
  }
}

class PopAdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Scaffold(
            backgroundColor: Colors.transparent,
            body: PopAdWidgetA(),
          );
      });
  }
}

class AdDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopAdWidget()
          ],
        );
  }
}

class PopAdWidgetA extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Light>(builder: (context, model, child) {
        return
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopAdWidget(),
            ],
          );
      });
  }
}


class PopAdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<Calculation>(builder: (context, model, child) {
        double screenSizeWidth = MediaQuery.of(context).size.width;
        final Future<String> _calculation = Future<String>.delayed(
            Duration(seconds: model.sum ~/ 100 + 4 ),
                () => '計算が終わりました'
        );
        return
            AWidget();
                });}}

class AWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.white,
        height: 180,
        child: Column(
          children: [
            PopAd(),
            Text("計算が終わりました"),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/calculate')
                , child: Text("表示")
            )
          ],
        ),
      );
  }
  }

