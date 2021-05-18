import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartModel {
  String month;
  String year;
  int financial;
  final charts.Color color;

  BarChartModel({this.month,
    this.year, this.financial,
    this.color,}
      );
}
final List<BarChartModel> data = [
  BarChartModel(
    year: "2014",
    financial: 250,
    color: charts.ColorUtil.fromDartColor
      (Color(0xFF47505F)),
  ),
  BarChartModel(
    year: "2015",
    financial: 300,
    color: charts.ColorUtil.fromDartColor
      (Colors.red),
  ),
  BarChartModel(
    year: "2016",
    financial: 100,
    color: charts.ColorUtil.fromDartColor
      (Colors.green),
  ),
  BarChartModel(
    year: "2017",
    financial: 450,
    color: charts.ColorUtil.fromDartColor
      (Colors.yellow),
  ),
  BarChartModel(
    year: "2018",
    financial: 630,
    color: charts.ColorUtil.fromDartColor
      (Colors.lightBlueAccent),
  ),
  BarChartModel(
    year: "2019",
    financial: 1000,
    color: charts.ColorUtil.fromDartColor
      (Colors.pink),
  ),
  BarChartModel(
    year: "2020",
    financial: 400,
    color: charts.ColorUtil.fromDartColor
      (Colors.purple),
  ),
];

List<charts.Series<BarChartModel, String>> series = [
  charts.Series(
      id: "Financial",
      data: widget.data,
      domainFn: (BarChartModel series, _) => series.year,
      measureFn: (BarChartModel series, _) => series.financial,
      colorFn: (BarChartModel series, _) => series.color),
];

return _buildFinancialList(series);

}

Widget _buildFinancialList(series) {
  return _barChartList != null
      ? ListView.separated(
    physics: NeverScrollableScrollPhysics(),
    separatorBuilder: (context, index) => Divider(
      color: Colors.white,
      height: 5,
    ),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: _barChartList.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: MediaQuery.of(context).size.height/ 2.3,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_barChartList[index].month,
                    style: TextStyle(
                        color: Colors.black, fontSize: 22,
                        fontWeight: FontWeight.bold)
                ),
              ],
            ),
            Expanded( child: charts.BarChart(series,
                animate: true)
            ),
          ],
        ),
      );
    },
  )
      : SizedBox();
}

