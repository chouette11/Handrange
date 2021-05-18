import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:handrange/bar_chart_model.dart';

class BarChartGraph extends StatefulWidget {
  final List<BarChartModel> data;

  const BarChartGraph({Key key, this.data}) : super(key: key);

  @override
  _BarChartGraphState createState() => _BarChartGraphState();
}

class _BarChartGraphState extends State<BarChartGraph> {
  List<BarChartModel> _barChartList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _barChartList = [
      BarChartModel(month: "Oct"),
      BarChartModel(month: "Nov"),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
        height: 0.51,
      ),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: _barChartList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery.of(context).size.height/ 2.3,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_barChartList[index].month,
                      style: TextStyle(
                          color: Colors.black, fontSize: 22,
                          fontWeight: FontWeight.bold)
                  ),
                ],
              ),
              Expanded( child: charts.BarChart(series, animate: true, vertical: false, )),
            ],
          ),
        );
      },
    )
        : SizedBox();
  }
}
