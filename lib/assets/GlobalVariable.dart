import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voteapp/models/models.dart';



class GlobalVariables {

  //static const String apiurl = 'http://192.168.1.100/';
  //static const String wsurl = 'ws://192.168.1.100/';

  static const String apiurl = 'http://apivote.gaddielsoftware.com/';
  static const String wsurl = 'ws://apivote.gaddielsoftware.com/';

  static String userName = "";
  static String password = "";
  static String noms = "";
  static String token = "";
  static bool isLoggedIn = false;

  static var BureauVotes;

  static var oneSignalAppId = "fe651a31-0bc9-4dad-b208-e1e7037f9205";

  static Future<void> showMyDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('VOTE'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showWaitDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Operation en cours..."),
          content: Container(
            width: 50,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
