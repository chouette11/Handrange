import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class BarChart extends StatefulWidget {
  BarChart({Key? key,  required this.comboList}) : super(key: key);
  final List<int> comboList;

  @override
  _BarChart createState() => _BarChart();
}

class _BarChart extends State<BarChart> {
  late List<VBarChartModel> barData;
  createBarData(){
    List<VBarChartModel> inputBarData = [];
    //List<String> labelName = ["Royal", "StraightFlush", "FourCards", "FullHouse", "Flush", "Straight", "ThreeCards", "TwoPair", "OnePair"];
    List<String> labelNameJ = ["ロイヤル", "ストフラ", "クワッズ", "フルハウス", "フラッシュ", "ストレート", "スリーカード", "ツーペア", "ワンペア"];

    int i;
    for(i = 0; i <= 8; i++){
      if(widget.comboList[9] == 0){
        inputBarData.add(
          VBarChartModel(
              index: i,
              label: labelNameJ[i],
              jumlah: 0,
              tooltip: "0.00% コンボ:0"
          ),
        );
      }
      else {
        inputBarData.add(
          VBarChartModel(
            index: i,
            label: labelNameJ[i],
            jumlah: ((widget.comboList[i] / (widget.comboList[9])) * 100),
            tooltip: "${((widget.comboList[i] / (widget.comboList[9]) * 100)
                .toStringAsFixed(2))}% コンボ:${widget.comboList[i].toInt()}",
          ),
        );
      }
    }
    barData = inputBarData;
  }
  List<VBarChartModel> initBarData(){
    List<VBarChartModel> barData = [];
    //List<String> labelName = ["Royal", "StraightFlush", "FourCards", "FullHouse", "Flush", "Straight", "ThreeCards", "TwoPair", "OnePair"];
    List<String> labelNameJ = ["ロイヤル", "ストフラ", "クワッズ", "フルハウス", "フラッシュ", "ストレート", "スリーカード", "ツーペア", "ワンペア"];

    int i;
    for(i = 0; i <= 8; i++){
      barData.add(
          VBarChartModel(
            index: i,
            label: labelNameJ[i],
            jumlah: 0,
          )
      );
    }
    return barData;
  }

  @override
  void initState() {
    super.initState();
    if (widget.comboList == []) {
      barData = initBarData();
    }
    else{
      createBarData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenSizeWidth = MediaQuery.of(context).size.width;
    return Container(width: screenSizeWidth, child: _buildGrafik(barData));
  }

  Widget _buildGrafik(List<VBarChartModel> barData) {
    return VerticalBarchart(
      maxX: 100,
      data: barData,
      showLegend: false,
      showBackdrop: false,
      barStyle: BarStyle.DEFAULT,
      alwaysShowDescription: true,
    );
  }
}