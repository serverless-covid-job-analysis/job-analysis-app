import 'package:demo/train_incoming_series.dart';
import 'package:flutter/material.dart';
import 'train_incoming_series.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class IncomingChart extends StatelessWidget {
  final List<TrainIncomingSeries> data;

  IncomingChart({@required this.data});
  @override
  @override
  Widget build(BuildContext context) {
    List<charts.Series<TrainIncomingSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (TrainIncomingSeries series, _) => series.city,
          measureFn: (TrainIncomingSeries series, _) => series.number,
          colorFn: (TrainIncomingSeries series, _) => series.barcolor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Incoming Traffic from Cities",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
