import 'package:flutter/material.dart';

class SavedRange extends StatelessWidget {
  SavedRange({
    Key? key,
    required this.name,
    required this.count,
    required this.text,
    this.onLongPress,
  }) : super(key: key);

  final String name;
  final int count;
  final String text;
  final void Function()? onLongPress;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(),
    );
  }
}