import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Drawer returnDrawer(BuildContext context,) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'メニュー',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.border_color),
          title: Text('レンジ作成'),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
          },
        ),
        ListTile(
          leading: Icon(Icons.apps_rounded),
          title: Text('レンジ一覧'),
          onTap: () {
            Navigator.pushNamed(context, '/save');
          },
        ),
        ListTile(
          leading: Icon(Icons.analytics),
          title: Text('役計算'),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/calculate', (Route<dynamic> route) => false);
          },
        ),
        ListTile(
          leading: Icon(Icons.analytics),
          title: Text('エクイティ計算'),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/equity', (Route<dynamic> route) => false);
          },
        ),
      ],
    ),
  );
}

