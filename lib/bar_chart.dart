import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class BarChartDemo extends StatefulWidget {
  BarChartDemo({Key key, this.title, this.comboList}) : super(key: key);

  final String title;
  final List<double> comboList;

  @override
  _BarChartDemo createState() => _BarChartDemo();
}

class _BarChartDemo extends State<BarChartDemo> {

  List<VBarChartModel> createBarData(){
    List<VBarChartModel> barData = [];
    int i;
    List<String> labelName = ["Royal", "StraightFlush", "FourCards", "FullHouse", "Flush", "Straight", "ThreeCards", "TwoPair", "OnePair"];
    for(i = 0; i <= 8; i++){
      barData.add(
          VBarChartModel(
              index: i,
              label: labelName[i],
              jumlah: widget.comboList[i],
              tooltip: "${((widget.comboList[i] / widget.comboList[9]) * 100).toStringAsFixed(2)}% combo:${widget.comboList[i].toInt()}"
          )
      );
    }
    return barData;
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          _buildGrafik(createBarData()),
        ],
      );
  }

  Widget _buildGrafik(List<VBarChartModel> barData) {
    return VerticalBarchart(
      maxX: 100,
      data: barData,
      showLegend: true,
      showBackdrop: true,
      barStyle: BarStyle.DEFAULT,
      alwaysShowDescription: true,
    );
  }
}