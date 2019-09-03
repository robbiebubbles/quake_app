import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {


  runApp(
    MaterialApp(
      home: Quakes("This is the tittle"),
    ),
  );
}

class Quakes extends StatelessWidget  {
final String tittle;

  const Quakes(this.tittle);

  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text("Quakes")),
        
      ),
      body: FutureBuilder(
        future: getQuake(),
        builder: (BuildContext buildContext,AsyncSnapshot snapshot){
          print(snapshot.data);
          if(snapshot.hasData && snapshot.data != null)
                return ListView.builder(
                itemBuilder:(BuildContext context, int positions){
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                  "${snapshot.data[positions]['properties']['place']}"
                        ),

                      )
                    ],
                  );
                });
          else return Container();
          },
      ),
    );
  }
}

Future<dynamic> getQuake() async {
  String apiURL =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(apiURL);
  return json.decode(response.body)['features'];
}
