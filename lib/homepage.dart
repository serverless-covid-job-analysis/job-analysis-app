import 'dart:html';

import 'train_journey_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'train_journey_series.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'barchart_incoming.dart';

class BarChart extends StatelessWidget {
  Future<List<TrainJourneySeries>> fetchAlbum() async {
    final response =
        await http.get('https://api.jsonbin.io/b/5f6880407243cd7e8240921b/3');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var temp = json.decode(response.body);
      print(temp);

      print(temp.length);
      List<TrainJourneySeries> data = [];
      for (var t in temp) {
        TrainJourneySeries train = TrainJourneySeries(
            t['source_city'],
            t['number_of_outgoing_passengers'],
            charts.ColorUtil.fromDartColor(Colors.blue));
        data.add(train);
      }
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  final List<TrainJourneySeries> data = [];

  @override
  Widget build(BuildContext context) {
    print('hi');
    fetchAlbum();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Outward Traffic from Cities"),
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
              onTap: () {},
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
          future: fetchAlbum(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            }
            return TrainJourneyChart(
              data: snapshot.data,
            );
          },
        ),
      ),
    );
  }
}
