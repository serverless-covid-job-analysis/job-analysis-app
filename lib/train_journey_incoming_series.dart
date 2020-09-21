import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class TrainJourneyIncomingSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

  TrainJourneyIncomingSeries(this.year, this.subscribers, this.barColor);
}
