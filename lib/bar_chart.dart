import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class BarChart extends StatefulWidget {
  BarChart({Key key, this.title, this.comboList}) : super(key: key);

  final String title;
  List<int> comboList;

  @override
  _BarChart createState() => _BarChart();
}

class _BarChart extends State<BarChart> {
  List<VBarChartModel> barData;
  createBarData(){
    List<VBarChartModel> inputBarData = [];
    int i;
    List<String> labelName = ["Royal", "StraightFlush", "FourCards", "FullHouse", "Flush", "Straight", "ThreeCards", "TwoPair", "OnePair"];
    for(i = 0; i <= 8; i++){
      inputBarData.add(
          VBarChartModel(
              index: i,
              label: labelName[i],
              jumlah: ((widget.comboList[i] / widget.comboList[9]) * 100),
              tooltip: "${((widget.comboList[i] / widget.comboList[9]) * 100).toStringAsFixed(2)}% combo:${widget.comboList[i].toInt()}"
          )
      );
    }
    barData = inputBarData;
  }

  List<VBarChartModel> initBarData(){
    List<VBarChartModel> barData = [];
    int i;
    List<String> labelName = ["Royal", "StraightFlush", "FourCards", "FullHouse", "Flush", "Straight", "ThreeCards", "TwoPair", "OnePair"];
    for(i = 0; i <= 8; i++){
      barData.add(
          VBarChartModel(
              index: i,
              label: labelName[i],
              jumlah: 0,
          )
      );
    }
    return barData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.comboList == [] || widget.comboList == null){
      barData = initBarData();
    }
    else{
      createBarData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          _buildGrafik(barData),
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