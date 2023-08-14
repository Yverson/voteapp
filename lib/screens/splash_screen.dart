import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voteapp/assets/GlobalVariable.dart';
import 'package:voteapp/models/models.dart';
import 'package:voteapp/screens/dashboard_screen.dart';
import 'package:voteapp/screens/sign_in_screen.dart';
import 'package:voteapp/screens/walk_through_screen.dart';
import 'package:voteapp/utils/images.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> CheckToken() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? userName = prefs.getString('userName');

    if(token != null)
    {

      GlobalVariables.token = token;
      GlobalVariables.userName = userName!;
      GlobalVariables.isLoggedIn = true;

      await fetchBureauVotes();


    }

  }


  Future<BureauVotes?> fetchBureauVotes() async {

      final Map<String, String> header = {
        'content-type': '	application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + GlobalVariables.token,
      };

      final response = await http.get(
          Uri.parse(GlobalVariables.apiurl + 'BureauVotes'),
          headers: header);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        var responseData = json.decode(response.body);


        //Creating a list to store input data;
        BureauVotes data = BureauVotes.fromJson(responseData);
        GlobalVariables.BureauVotes = data;
        return data;

      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //throw Exception('Failed to load album');
        return null;
      }

  }


  @override
  void initState() {
    //CheckToken();
    super.initState();
    init();
  }

  void init() async {
    Timer(
      Duration(seconds: 2),
      () {

        if(GlobalVariables.isLoggedIn)
          {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen()),
                  (route) => false,
            );
          }
        else
          {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
            );
          }

      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(splash_logo, width: 100, height: 100, fit: BoxFit.cover),
      ),
    );
  }
}
