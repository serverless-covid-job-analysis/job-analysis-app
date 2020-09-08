import 'train_journey_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'train_journey_series.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {

  Future<List<TrainJourneySeries>> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // var temp = json.decode(response.body);
    var temp = [
   {
      "index":0,
      "source_state":"MAH",
      "source_city":"Mumbai",
      "destination_state":"Bihar",
      "destination_city":"Bhagalpur",
      "number_of_trains":15,
      "number_of_passengers":176859
   },
   {
      "index":1,
      "source_state":"UP",
      "source_city":"Gopalpur",
      "destination_state":"Bihar",
      "destination_city":"Bhagalpur",
      "number_of_trains":15,
      "number_of_passengers":136852
   },
   {
      "index":2,
      "source_state":"MP",
      "source_city":"Indore",
      "destination_state":"Bihar",
      "destination_city":"Bhagalpur",
      "number_of_trains":15,
      "number_of_passengers":116857
   },
   {
      "index":3,
      "source_state":"WB",
      "source_city":"Gopalpur",
      "destination_state":"Bihar",
      "destination_city":"Bhagalpur",
      "number_of_trains":15,
      "number_of_passengers":156857
   },
   {
      "index":4,
      "source_state":"KL",
      "source_city":"Gopalpur",
      "destination_state":"Bihar",
      "destination_city":"Bhagalpur",
      "number_of_trains":15,
      "number_of_passengers":186851
   }
];

    print(temp.length);
    List<TrainJourneySeries> data = [];
    for (var t in temp) {
        TrainJourneySeries train = TrainJourneySeries(t['source_state'],t['number_of_passengers'],charts.ColorUtil.fromDartColor(Colors.blue));
        data.add(train);
    }
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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
        title: Text("Outward Traffic from States"),
      ),
        body: Container(
            child: FutureBuilder(
                future: fetchAlbum(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading...")
                        )
                      );
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
