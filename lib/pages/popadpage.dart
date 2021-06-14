import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/light.dart';
import 'package:provider/provider.dart';
import '../components/widgets/ad_state.dart';
import '../providers/calculation.dart';

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
    return Consumer<Light>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body:WillPopScope(
          onWillPop: () async => false,
          child: PopAdDisplay(),
        ),
      );
    });
  }
}

class PopAdDisplay extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PopAdWidget(),
        ],
      ),
    );
  }
}


class PopAdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Calculation>(builder: (context, model, child) {
      final Future<String> _calculation = Future<String>.delayed(
          Duration(seconds: model.sum ~/ 100 + 3 ),
              () => '計算が終わりました'
      );

      return
        FutureBuilder(
            future: _calculation,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  height: 180,
                  child: Column(
                    children: [
                      PopAd(),
                      Container(
                        padding:EdgeInsets.only(top: 3),
                        child: Text("計算が完了しました"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          model.onVisible();
                          Navigator.pop(context);
                        },
                        child: Text("表示"),
                      ),
                    ],
                  ),
                );
              }
              else{
                return Container(
                  color: Colors.white,
                  height: 240,
                  child: Column(
                    children: [
                      PopAd(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("計算中です"),
                          Container(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(strokeWidth: 1.5,),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ご利用ありがとうございます"),
                          Text("現在レビューキャンペーンをやってます"),
                          Text("詳しくはtwitter_@chouette11まで"),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        child: Text("キャンセル"),
                      ),
                    ],
                  ),
                );
              }
            }
        );
    });
  }
}

