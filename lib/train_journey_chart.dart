import 'package:charts_flutter/flutter.dart' as charts;
import 'train_journey_series.dart';
import 'package:flutter/material.dart';

class TrainJourneyChart extends StatelessWidget {
  final List<TrainJourneySeries> data;

  TrainJourneyChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TrainJourneySeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (TrainJourneySeries series, _) => series.year,
          measureFn: (TrainJourneySeries series, _) => series.subscribers,
          colorFn: (TrainJourneySeries series, _) => series.barColor)
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