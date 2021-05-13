import 'package:flutter/material.dart';
import 'package:handrange/calculation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:handrange/light.dart';
import 'package:handrange/combination.dart';
import 'package:handrange/drawer.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Handrange',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: SelectPage(),
    );
  }
}

class SelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Container(
          child: Consumer<Light>(builder: (context, model, child) {
            return
              Scaffold(
                appBar: AppBar(
                  title: Text('Handrange'),
                ),
                drawer: returnDrawer(context, model.createGraphs()),
                body: SelectCard(),
              );
          })
      );
  }
}

class SelectCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}