import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/ad/components/pop_ad.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../calculates/hand/models/hand_page_model.dart';

class PopAdPage extends StatelessWidget {
  PopAdPage({Key? key, required this.time}) : super(key: key);
  final double time;

  @override
  Widget build(BuildContext context) {
    final double screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<HandPageModel>(builder: (context, model, child) {
              final Future<String> _calculation = Future<String>.delayed(
                  Duration(seconds: time.toInt()),
                      () => '計算が終わりました'
              );

              return FutureBuilder(
                    future: _calculation,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: screenSizeWidth,
                          height: 180,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          color: Colors.white,
                          child: Column(
                            children: [
                              PopAd(),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                  child: Text("計算が完了しました")
                              ),
                              RaisedButton(
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/equity', (Route<dynamic> route) => false),
                                child: Text("表示"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          width: screenSizeWidth,
                          height: 200,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          color: Colors.white,
                          child: Column(
                            children: [
                              PopAd(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("計算中です"),
                                  Container(
                                    margin: EdgeInsets.only(left: 4),
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 1.5),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("ご利用ありがとうございます"),
                                  Text("不具合・改善点がありましたらお問い合わせください"),
                                  Container(
                                    child: InkWell(
                                      child: Text(
                                        "twitter_@chouette111まで",
                                        style: TextStyle(color: Colors.lightBlue),
                                      ),
                                      onTap: () async {
                                        const url = "https://twitter.com/chouette111";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not Launch $url';
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    }
                );
            }),
          ],
        ),
      ),
    );
  }
}

class PopAdPageAndroid extends StatefulWidget {
  PopAdPageAndroid({Key? key, required this.time}) : super(key: key);
  final double time;

  @override
  _PopAdPageAndroidState createState() => _PopAdPageAndroidState();
}

class _PopAdPageAndroidState extends State<PopAdPageAndroid> {
  bool isCalculate = false;
  @override
  Widget build(BuildContext context) {
    int minute = (widget.time ~/ 60) + 1;
    final double screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<EquityPageModel>(builder: (context, model, child) {
              print(widget.time);
              final Future<String> _calculation = Future<String>.delayed(
                  Duration(seconds: widget.time.toInt()),
                      () => '計算が終わりました'
              );

              return FutureBuilder(
                  future: _calculation,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        width: screenSizeWidth,
                        height: 180,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text("計算が完了しました",
                                style: TextStyle(
                                  fontSize: 16
                                ),)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/equity', (Route<dynamic> route) => false),
                                child: Text("表示"),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BottomAd(),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        width: screenSizeWidth,
                        height: 200,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("計算中です"),
                                  Container(
                                    margin: EdgeInsets.only(left: 4),
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 1.5),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("想定時間$minute分"),
                                  Text("ご利用ありがとうございます"),
                                  Text("不具合・改善点がありましたらお問い合わせください"),
                                  Container(
                                    child: InkWell(
                                      child: Text(
                                        "twitter_@chouette555まで",
                                        style: TextStyle(color: Colors.lightBlue),
                                      ),
                                      onTap: () async {
                                        const url = "https://twitter.com/chouette555";
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not Launch $url';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BottomAd(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
              );
            }),
          ],
        ),
      ),
    );
  }
}