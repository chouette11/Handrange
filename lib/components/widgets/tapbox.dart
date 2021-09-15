import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTapBox extends StatelessWidget {
  CustomTapBox({
    required this.isSelected,
    this.onPressed,
    this.name = "",
    this.radius = 0,
  });
  final bool isSelected;
  final void Function()? onPressed;
  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width / 29;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 0.5, color: Colors.white),
          color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                fontFamily: "Sans",
                fontSize: boxWidth
            ),
          ),
        ),
      ),
    );
  }
}