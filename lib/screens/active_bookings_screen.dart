import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:voteapp/assets/GlobalVariable.dart';

import 'package:http/http.dart' as http;
import 'package:voteapp/models/models.dart';

class ActiveBookingsScreen extends StatefulWidget {
  const ActiveBookingsScreen({Key? key}) : super(key: key);

  @override
  State<ActiveBookingsScreen> createState() => _ActiveBookingsScreenState();
}

class _ActiveBookingsScreenState extends State<ActiveBookingsScreen> {
  List<Documents> _photos = [];
  TextEditingController _descriptionController = TextEditingController();

  void _addPhotoFromGallery() async {

    try
    {
      // Ensure that plugin services are initialized so that `availableCameras()`
      // can be called before `runApp()`
      WidgetsFlutterBinding.ensureInitialized();

      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        await sendImage(File(pickedFile.path), GlobalVariables.BureauVotes.Id, _descriptionController.text);
      }

    }
    on Exception catch (_) {
      print('never reached');
    }


  }

  Future<void> sendImage(File imageFile, String id, String desc) async {

    var request = http.MultipartRequest('POST', Uri.parse(GlobalVariables.apiurl + 'api/Photos/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    request.headers['Authorization'] = 'Bearer ' + GlobalVariables.token;
    request.fields['id'] = id.toString(); // Include the ID in the request fields
    request.fields['description'] = desc.toString(); // Include the ID in the request fields

    var response = await request.send();
    if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded successfully');

      setState(() {
      });

    } else {
      // Error uploading image
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: _addPhotoFromGallery,
                    child: Text('Ajouter une Photo'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: FutureBuilder(
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(_photos[index].documents),
                          );
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
          ),
        ],
      ),
    );
  }


  Future<List<Documents>> fetchHistoriques() async {
    final Map<String, String> header = {
      'content-type': '	application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + GlobalVariables.token,
      'id': GlobalVariables.BureauVotes.Id,
    };

    final response = await http
        .get(Uri.parse(GlobalVariables.apiurl + 'Documents'), headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseData = json.decode(response.body);

      //Creating a list to store input data;
      List<Documents> data = [];
      for (var singleUser in responseData) {
        Documents r = Documents.fromJson(singleUser);
        //Adding user to the list.
        data.add(r);
      }

      _photos = data;

      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load album');
      return [];
    }
  }

}
