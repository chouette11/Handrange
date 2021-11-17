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
          mainAxisAlignment: MainAxisAlignment.start,
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
                          height: 400,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          color: Colors.white,
                          child: Column(
                            children: [
                              PopAd(),
                              Text("計算が完了しました"),
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
                          height: 400,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          color: Colors.white,
                          child: Column(
                            children: [
                              PopAd(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("計算中です"),
                                  CircularProgressIndicator(strokeWidth: 1.5)
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
