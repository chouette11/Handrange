import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/gridview.dart';
import 'package:handrange/components/tapbox.dart';
import '../../components/functions/creategraph.dart';

class AlertSavedRange extends StatelessWidget {
  AlertSavedRange({
    Key? key,
    required this.name,
    required this.count,
    required this.text,
    required this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final String name;
  final int count;
  final String text;
  final void Function() onPressed;
  final void Function()? onLongPress;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Column(
        children: [
          HandRange(
            children: getIsSelected(text).map((e) =>
                GridTile(child: CustomTapBox(isSelected: e["isSelected"]),
                )).toList(),
            size: 3.3,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "VPIP ${((count / 1326) * 100).toStringAsFixed(2)}%",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
