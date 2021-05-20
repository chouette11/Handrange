import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

class BarChartDemo extends StatefulWidget {
  BarChartDemo({Key key, this.title, this.comboList}) : super(key: key);

  final String title;
  final List<double> comboList;

  @override
  _BarChartDemo createState() => _BarChartDemo();
}

class _BarChartDemo extends State<BarChartDemo> {
  List<VBarChartModel> barData = [
    VBarChartModel(
      index: 0,
      label: "Royal",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: widget.comboList[0],
      tooltip: "20 Pcs",
    ),
    VBarChartModel(
      index: 1,
      label: "StraightFlush",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 55,
      tooltip: "55 Pcs",
    ),
    VBarChartModel(
      index: 2,
      label: "FourCards",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 12,
      tooltip: "12 Pcs",
    ),
    VBarChartModel(
      index: 3,
      label: "FullHouse",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 1,
      tooltip: "5 Pcs",
    ),
    VBarChartModel(
      index: 4,
      label: "Flush",
      colors: [Colors.orange, Colors.deepOrange],
      jumlah: 15,
      tooltip: "15 Pcs",
    ),
    VBarChartModel(
      index: 5,
      label: "Straight",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
    ),
    VBarChartModel(
      index: 6,
      label: "ThreeCards",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
    ),
    VBarChartModel(
      index: 7,
      label: "TwoPair",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
    ),
    VBarChartModel(
      index: 8,
      label: "OnePair",
      colors: [Colors.teal, Colors.indigo],
      jumlah: 30,
      tooltip: "30 Pcs",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              _buildGrafik(barData),
            ],
          )),
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
      legend: [
        Vlegend(
          isSquare: false,
          color: Colors.orange,
          text: "Fruits",
        ),
        Vlegend(
          isSquare: false,
          color: Colors.teal,
          text: "Vegetables",
        )
      ],
    );
  }
}