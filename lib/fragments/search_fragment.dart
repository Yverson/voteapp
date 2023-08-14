import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voteapp/assets/GlobalVariable.dart';
import 'package:voteapp/components/search_component.dart';
import 'package:voteapp/custom_widget/space.dart';
import 'package:voteapp/models/models.dart';
import 'package:voteapp/utils/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:voteapp/utils/images.dart';

import '../utils/colors.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  List<Candidats> allCandidats = [];

  List<String> allImages = [plumber,electrician,painter,carpenter,homeCleaner,painter1,electrician];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Liste des Candidats",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetchCandidats(),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text("Voulez-vous vraiment votez ?"),
                                    content: Text(
                                        allCandidats[index].description.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('ANNULER'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          var res =
                                              await Save(allCandidats[index]);
                                          if (res == true) {
                                            Navigator.pop(context);

                                            setState(() {});
                                          }
                                        },
                                        child: Text('CONFIRMER'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Card(
                              color: transparent,
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: (allCandidats[index]!.Photo != null || allCandidats[index]!.Photo != "")
                                        ?  Image.network(allCandidats[index]!.Photo, width: 100, height: 100, fit: BoxFit.cover)
                                        : Image.asset(allImages[index]!, width: 100, height: 100, fit: BoxFit.cover),
                                  ),
                                  Space(16),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allCandidats[index]!.partie,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      ),
                                      Space(4),
                                      Text(
                                        allCandidats[index]!.noms,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
          ],
        ),
      ),
    );
  }

  Future<bool> Save(Candidats candidat) async {
    try {
      GlobalVariables.showWaitDialog(context);
      final Map<String, String> header = {
        'content-type': '	application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + GlobalVariables.token,
      };

      Votes data = new Votes();
      data.description = candidat.description;
      data.quantite = 1;
      data.typeOperations = "ELECTION";
      data.candidatsId = candidat.id;
      data.typeVotes = "";

      var encodeData = json.encode(data);

      final response = await http.post(
          Uri.parse(GlobalVariables.apiurl + 'Votes'),
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

  Future<List<Candidats>> fetchCandidats() async {
    final Map<String, String> header = {
      'content-type': '	application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + GlobalVariables.token,
    };

    final response = await http
        .get(Uri.parse(GlobalVariables.apiurl + 'Candidats'), headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseData = json.decode(response.body);

      //Creating a list to store input data;
      List<Candidats> data = [];
      for (var singleUser in responseData) {
        Candidats r = Candidats.fromJson(singleUser);
        //Adding user to the list.
        data.add(r);
      }

      allCandidats = data;

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
      return [];
    }
  }
}
