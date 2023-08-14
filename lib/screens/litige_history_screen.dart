import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voteapp/assets/GlobalVariable.dart';
import 'package:voteapp/components/booking_history_component.dart';
import 'package:voteapp/components/litige_history_component.dart';
import 'package:voteapp/models/last_bookings_model.dart';
import 'package:voteapp/models/models.dart';
import 'package:http/http.dart' as http;

class LitigeHistoryScreen extends StatefulWidget {
  const LitigeHistoryScreen({Key? key}) : super(key: key);

  @override
  State<LitigeHistoryScreen> createState() => _LitigeHistoryScreenState();
}

class _LitigeHistoryScreenState extends State<LitigeHistoryScreen> {
  List<TypeIncidents> allVotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:             FutureBuilder(
          future: fetchHistoriques(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LitigeHistoryComponent(index, allVotes: snapshot.data);
                  },
                );
              } else {
                return Container();
              }
            } else if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }

  Future<List<TypeIncidents>> fetchHistoriques() async {
    final Map<String, String> header = {
      'content-type': '	application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + GlobalVariables.token,
    };

    final response = await http
        .get(Uri.parse(GlobalVariables.apiurl + 'TypeIncidents'), headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseData = json.decode(response.body);

      //Creating a list to store input data;
      List<TypeIncidents> data = [];
      for (var singleUser in responseData) {
        TypeIncidents r = TypeIncidents.fromJson(singleUser);
        //Adding user to the list.
        data.add(r);
      }
      data.sort((a, b) => b.created.compareTo(a.created));
      allVotes = data;

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
      return [];
    }
  }

  }
