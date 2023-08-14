import 'dart:convert';

import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voteapp/assets/GlobalVariable.dart';
import 'package:voteapp/assets/LoginData.dart';
import 'package:voteapp/models/models.dart';
import 'package:voteapp/screens/otp_verification_screen.dart';
import 'package:voteapp/screens/sign_up_screen.dart';
import 'package:voteapp/utils/constant.dart';
import 'package:voteapp/utils/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import 'dashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  String login = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarIconBrightness: appData.isDark ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space(60),
                  Text("Bienvenue!", style: TextStyle(fontSize: mainTitleTextSize, fontWeight: FontWeight.bold)),
                  Space(8),
                  Text("Connecter-vous", style: TextStyle(fontSize: 14, color: subTitle)),
                  Space(16),
                  Image.asset(splash_logo, width: 100, height: 100, fit: BoxFit.cover),
                ],
              ),
              Space(70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 16),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: commonInputDecoration(
                      hintText: "Enter mobile number",
                    ),
                    onChanged: (text) {
                      login =  text;
                    },
                  ),
                  Space(32),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 16),
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: commonInputDecoration(
                      hintText: "Enter password",
                    ),
                    onChanged: (text) {
                      password =  text;
                    },
                  ),
                  Space(16),
                ],
              ),
              Space(16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    textStyle: TextStyle(fontSize: 16),
                    shape: StadiumBorder(),
                    backgroundColor: appData.isDark ? Colors.grey.withOpacity(0.2) : Colors.black,
                  ),
                  onPressed: () async {
                    LoginDriver(login, password);
                  },
                  child: Text("Log In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void LoginDriver(String userName, String password) async {
    try {


      GlobalVariables.showWaitDialog(context);
      final Map<String, String> header = {
        'content-type': '	application/json',
        'Accept': 'application/json',
      };

      LoginData data = new LoginData();
      data.userName = userName;
      data.password = password;

      var encodeData = json.encode(data);

      final response = await http
          .post(Uri.parse(GlobalVariables.apiurl + 'Identity/Login'), headers: header, body: encodeData);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        var responseData = json.decode(response.body);
        GlobalVariables.token = responseData["Token"];
        GlobalVariables.userName = userName;
        GlobalVariables.password = password;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", GlobalVariables.token);
        await prefs.setString("userName", userName);
        await prefs.setString("password", password);

        await fetchBureauVotes();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashBoardScreen()),
              (route) => false,
        );


      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        //throw Exception('Failed to load ListeDriver');
        GlobalVariables.showMyDialog(context, "La connection a échoué");
      }

    } catch (error) {
      GlobalVariables.showMyDialog(context, error.toString());
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


}
