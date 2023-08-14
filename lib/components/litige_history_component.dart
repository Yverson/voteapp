import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voteapp/assets/GlobalVariable.dart';
import 'package:voteapp/custom_widget/space.dart';
import 'package:voteapp/main.dart';
import 'package:voteapp/models/last_bookings_model.dart';
import 'package:voteapp/models/models.dart';
import 'package:voteapp/utils/colors.dart';
import 'package:voteapp/utils/images.dart';
import 'package:voteapp/utils/widgets.dart';
import 'package:http/http.dart' as http;

class LitigeHistoryComponent extends StatelessWidget {
  List<TypeIncidents>? allVotes = [];
  final int index;

  LitigeHistoryComponent(this.index, {this.allVotes});

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var timeFormat = DateFormat('HH:mm');

    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Divider(color: dividerColor, thickness: 1),
                Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          allVotes![index].description,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.green,
                              fontSize: 16),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.clip,
                        ),
                        Space(4),
                        Container(
                          width: width - 60,
                          child: Text(allVotes![index].commentaire.toString(),
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        Space(4),
                        TextButton(
                          onPressed: () async {
                            await Save(allVotes![index], context);
                          },
                          child: Container(
                            color: Colors.green.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: const Text(
                              'Signaler',
                              style: TextStyle(color: Colors.white, fontSize: 13.0),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Space(4),
                Divider(color: dividerColor, thickness: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> Save(TypeIncidents incident, BuildContext context) async {
    try {
      GlobalVariables.showWaitDialog(context);
      final Map<String, String> header = {
        'content-type': '	application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + GlobalVariables.token,
      };

      Incidents data = new Incidents();
      data.description = incident.description;
      data.commentaire = incident.commentaire;

      var encodeData = json.encode(data);

      final response = await http.post(
          Uri.parse(GlobalVariables.apiurl + 'Incidents'),
          headers: header,
          body: encodeData);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        var responseData = json.decode(response.body);
        Navigator.pop(context);
        return true;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //throw Exception('Failed to load ListeDriver');
        GlobalVariables.showMyDialog(context, "La connection a échoué");
        return false;
      }
    } catch (error) {
      GlobalVariables.showMyDialog(context, error.toString());
      return false;
    }
  }

}
