import 'package:flutter/material.dart';

Drawer returnDrawer(BuildContext context,) {
  return
  Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.graphic_eq_sharp),
          title: Text('Graphs'),
          onTap: ()  {
             Navigator.pushNamed(context, '/save');
          },
        ),
        ListTile(
          leading: Icon(Icons.file_copy),
          title: Text('Calculate'),
          onTap: ()  {
            Navigator.pushNamed(context, '/calculate');
          },
        ),
      ],
    ),
  );
}