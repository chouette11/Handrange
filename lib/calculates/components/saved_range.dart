import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/components/widgets/gridview.dart';
import 'package:handrange/components/widgets/tapbox.dart';
import '../../components/functions/creategraph.dart';

class SavedRange extends StatelessWidget {
  SavedRange({
    Key? key,
    required this.num,
    required this.name,
    required this.count,
    required this.text,
    required this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final int num;
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
                Text("VPIP ${((count / 1326) * 100).toStringAsFixed(2)}%"),
                Text(name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
