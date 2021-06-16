import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/widgets/ad_state.dart';
import 'package:handrange/components/widgets/drawer.dart';
import 'package:handrange/datas/initsql.dart';
import 'package:handrange/datas/sql.dart';
import 'package:handrange/providers/light.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MakeRangePage extends StatefulWidget{
  @override
  _MakeRangePageState createState() => _MakeRangePageState();
}

class _MakeRangePageState extends State<MakeRangePage> {
  final myController = TextEditingController();

  String _authStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    // Can't show a dialog in initState, delaying initialization
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        // Show a custom explainer dialog before the system dialog
        if (await showCustomTrackingDialog(context)) {
          // Wait for dialog popping animation
          await Future.delayed(const Duration(milliseconds: 200));
          // Request system's tracking authorization dialog
          final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();
          setState(() => _authStatus = '$status');
        }
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  Future<bool> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ユーザーの皆様へ'),
          content: const Text(
            "この度は”ポーカー計算 ハンドレンジ”をダウンロードしていただきありがとうございます。\n"
                "申し訳ないのですがこのアプリでは広告が表示されます。\n"
                "トラッキングを許可すると某サイトのおすすめのようにあなた様にあった広告が表示されやすくなります\n"
                "(許可しなくともアプリのすべての機能を利用することができます)",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("トラッキングをしないように要求"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('許可'),
            ),
          ],
        ),
      ) ??
          false;

  @override
  Widget build(BuildContext context) {
    final initGraphs = Provider.of<List<InitGraph>?>(context);
    return Consumer<Light>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text("レンジ作成"),
          ),
          drawer: returnDrawer(context),
          body:Consumer<Light>(builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    model.graphName,
                    style: TextStyle(
                      fontFamily: "Sans",
                    ),
                  ),
                ),
                DisplayGraph(),
                TextField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        onPressed: () async{
                          await model.getInitGraph(3);
                        },
                        child: Text("UTG")
                    ),
                    RaisedButton(
                        onPressed: () async {
                          await model.getInitGraph(4);
                        },
                        child: Text("HJ")),
                    RaisedButton(
                        onPressed: () async {
                          await model.getInitGraph(5);
                        },
                        child: Text("CO")),
                    RaisedButton(
                        onPressed: () async {
                          await model.getInitGraph(6);
                        },
                        child: Text("BTN")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () async{
                        final initGraphs = await InitGraph.getInitGraph();
                        if (initGraphs[0].name == "noName1" && initGraphs[0].count == 0) {
                          showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                              title:Text("エラー"),
                              children: <Widget>[
                                SimpleDialogOption(
                                  child: Column(
                                    children: [
                                      Text('レンジが保存されていません'),
                                      Text("レンジ一覧から長押しでボタンに保存してください"),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        await model.getInitGraph(0);
                      },
                      child: Text(
                          model.isNames[0] ? model.initGraphName[0] : initGraphs![0].name
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async{
                        final initGraphs = await InitGraph.getInitGraph();
                        if (initGraphs[1].name == "noName2" && initGraphs[1].count == 0) {
                          showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                              title:Text("エラー"),
                              children: <Widget>[
                                SimpleDialogOption(
                                  child: Column(
                                    children: [
                                      Text('レンジが保存されていません'),
                                      Text("レンジ一覧から長押しでボタンに保存してください"),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        await model.getInitGraph(1);
                      },
                      child: Text(
                          model.isNames[1] ? model.initGraphName[1] : initGraphs![1].name
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async{
                        final initGraphs = await InitGraph.getInitGraph();
                        if (initGraphs[2].name == "noName3" && initGraphs[2].count == 0) {
                          showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                              title:Text("エラー"),
                              children: <Widget>[
                                SimpleDialogOption(
                                  child: Column(
                                    children: [
                                      Text('レンジが保存されていません'),
                                      Text("レンジ一覧から長押しでボタンに保存してください"),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        await model.getInitGraph(2);
                      },
                      child: Text(
                          model.isNames[2] ? model.initGraphName[2] : initGraphs![2].name
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                        child: Text('Pockets'),
                        onPressed: () {
                          model.onPocket();
                        }
                    ),
                    RaisedButton(
                        child: Text('クリア'),
                        onPressed: () {
                          model.onClear();
                        }
                    ),
                    ElevatedButton(
                        child: Text('保存'),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("新規ハンドレンジ作成"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('名前を入力してね'),
                                  TextFormField(controller: myController),
                                  RaisedButton(
                                    child: Text('実行'),
                                    onPressed: () async {
                                      String name;
                                      name = myController.text;
                                      myController.clear();
                                      await saveGraph(model.status, name, model.count);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                    ElevatedButton(
                        onPressed: () {
                          updateGraph(model.status, model.graphId, model.graphCount, model.graphName);
                        },
                        child: Text("更新")
                    ),
                  ],
                ),
              ],
            );
          })
      );
    });
  }
}
//=============================================================================
// 表示
class TextField extends StatefulWidget {
  @override
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      child:Consumer<Light>(builder: (context, model, child) {
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

class DisplayGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child: Consumer<Light>(builder: (context, model, child) {
        return GridView.count(
          crossAxisCount: 13,
          mainAxisSpacing: 0.001,
          crossAxisSpacing: 0.001,
          children: model.status.map((e) => GridTile(
            child: TapBox(hand: e["hand"], isSelected: e["isSelected"]),
          ),
          ).toList(),
        );
      },
      ),
    );
  }
}

class TapBox extends StatelessWidget {
  TapBox( {Key? key, required this.hand, required this.isSelected }) : super(key: key);
  final String hand;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width / 29;
    return Consumer<Light>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          model.onTapped(hand);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          ),
          child:Center(
            child: Text(
              hand,
              style: TextStyle(
                  fontFamily: "Sans",
                  fontSize: boxWidth
              ),
            ),
          ),
        ),
      );
    });
  }
}
