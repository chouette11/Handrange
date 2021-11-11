import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HandRange extends StatelessWidget {
  HandRange({Key? key, required this.children, required this.size}) : super(key: key);
  final List<Widget> children;
  final double size;
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width / size;
    return Container(
      width: screenSizeWidth,
      height: screenSizeWidth,
      color: Colors.white,
      child:GridView.count(
        crossAxisCount: 13,
        mainAxisSpacing: 0.001,
        crossAxisSpacing: 0.001,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children,
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  CustomGridView({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenSizeWidth,
      margin: EdgeInsets.only(left: 1,right: 1,top: 1),
      child:GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0.5,
        crossAxisSpacing: 1,
        childAspectRatio: 0.75,
        children: children,
      ),
    );
  }
}
