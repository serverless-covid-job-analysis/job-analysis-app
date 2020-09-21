import 'package:charts_flutter/flutter.dart' as charts;
import 'train_journey_series.dart';
import 'package:flutter/material.dart';
import 'train_journey_incoming_series.dart';

class TrainJourneyincomingChart extends StatelessWidget {
  final List<TrainJourneyIncomingSeries> data;

  TrainJourneyIncomingChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TrainJourneyIncomingSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (TrainJourneyIncomingSeries series, _) => series.year,
          measureFn: (TrainJourneyIncomingSeries series, _) =>
              series.subscribers,
          colorFn: (TrainJourneyIncomingSeries series, _) => series.barColor)
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
                "Outward Traffic from States",
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
