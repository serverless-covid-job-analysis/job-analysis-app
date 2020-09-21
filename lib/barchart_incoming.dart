import 'dart:html';

import 'train_journey_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'train_journey_series.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'train_incoming_series.dart';
import 'homepage.dart';
import 'train_incoming_chart.dart';

class BarChartIncoming extends StatelessWidget {
  Future<List<TrainIncomingSeries>> fetchoutward() async {
    final response1 =
        await http.get('https://api.jsonbin.io/b/5f6880407243cd7e8240921b/3');
    if (response1.statusCode == 200) {
      var temp_out = json.decode(response1.body);
      List<TrainIncomingSeries> data1 = [];
      for (var t in temp_out) {
        TrainIncomingSeries train1 = TrainIncomingSeries(
            t['source_city'],
            t['number_of_outgoing_passengers'],
            charts.ColorUtil.fromDartColor(Colors.red));
        data1.add(train1);
      }
      return data1;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  final List<TrainIncomingSeries> data1 = [];

  @override
  Widget build(BuildContext context) {
    print('hi');
    fetchoutward();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Covid Migration Analysis "),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new ListTile(
              title: new Text('Outward Traffic Chart'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new BarChart()));
              },
            ),
            new ListTile(
              title: new Text("Incoming Traffic Chart"),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new BarChartIncoming()));
              },
            ),
            new ListTile(
              title: new Text("Domain Wise Analysis"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchoutward(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            }
            return IncomingChart(
              data: snapshot.data,
            );
          },
        ),
      ),
    );
  }
}
