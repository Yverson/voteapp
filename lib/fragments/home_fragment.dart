import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:voteapp/assets/GlobalVariable.dart';
import 'package:voteapp/components/combos_subscriptions_component.dart';
import 'package:voteapp/components/customer_review_component.dart';
import 'package:voteapp/components/home_contruction_component.dart';
import 'package:voteapp/components/home_service_component.dart';
import 'package:voteapp/components/popular_service_component.dart';
import 'package:voteapp/components/renovate_home_component.dart';
import 'package:voteapp/fragments/bookings_fragment.dart';
import 'package:voteapp/models/customer_details_model.dart';
import 'package:voteapp/models/models.dart';
import 'package:voteapp/models/renovate_services_model.dart';
import 'package:voteapp/screens/notification_screen.dart';
import 'package:voteapp/screens/service_providers_screen.dart';
import 'package:voteapp/screens/sign_in_screen.dart';
import 'package:voteapp/utils/images.dart';
import 'package:voteapp/utils/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import '../../custom_widget/space.dart';
import '../main.dart';
import '../models/customer_review_model.dart';
import '../models/services_model.dart';
import '../screens/all_categories_screen.dart';
import '../screens/favourite_services_screen.dart';
import '../screens/my_profile_screen.dart';
import '../utils/colors.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  double aspectRatio = 0.0;
  int homme = 0;
  int femme = 0;
  List<String> listePersonnes = [];

  @override
  void initState() {
    super.initState();
    homme = GlobalVariables.BureauVotes != null ? GlobalVariables.BureauVotes.Hommes : 0;
    femme = GlobalVariables.BureauVotes!= null ? GlobalVariables.BureauVotes.Femmes : 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showLogOutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to Logout?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    aspectRatio = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparent,
        iconTheme: IconThemeData(size: 30),
        title: Text(
          "Taux de participation",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 24),
              color: appData.isDark ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "J",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: appData.isDark ? Colors.black : whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appData.isDark ? whiteColor : Colors.black,
                    ),
                  ),
                  Space(4),
                  Text(
                    getName,
                    style: TextStyle(
                        fontSize: 18,
                        color: appData.isDark ? whiteColor : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Space(4),
                  Text(getEmail, style: TextStyle(color: secondaryColor)),
                ],
              ),
            ),
            drawerWidget(
              drawerTitle: "My Profile",
              drawerIcon: Icons.person,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfileScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My Favourites",
              drawerIcon: Icons.favorite,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavouriteProvidersScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "Notifications",
              drawerIcon: Icons.notifications,
              drawerOnTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
            ),
            drawerWidget(
              drawerTitle: "My bookings",
              drawerIcon: Icons.calendar_month,
              drawerOnTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BookingsFragment(fromProfile: true)),
                );
              },
            ),
            drawerWidget(
              drawerTitle: "Refer and earn",
              drawerIcon: Icons.paid_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Contact Us",
              drawerIcon: Icons.mail,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Help Center",
              drawerIcon: Icons.question_mark_rounded,
              drawerOnTap: () {
                Navigator.pop(context);
              },
            ),
            drawerWidget(
              drawerTitle: "Logout",
              drawerIcon: Icons.logout,
              drawerOnTap: () {
                Navigator.pop(context);
                _showLogOutDialog();
              },
            ),
          ],
        ),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(8),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff2972ff),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      GlobalVariables.BureauVotes != null ? GlobalVariables.BureauVotes!.Campagnes : "",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 5, width: 16),
                    Text(
                      GlobalVariables.BureauVotes != null ? GlobalVariables.BureauVotes!.Tours : "",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 5, width: 16),
                    Text(
                      GlobalVariables.BureauVotes != null ? GlobalVariables.BureauVotes!.Centres : "",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 5, width: 16),
                    Text(
                      GlobalVariables.BureauVotes != null ? GlobalVariables.BureauVotes!.LocationBvs : "",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 5, width: 16),
                    Text(
                      GlobalVariables.BureauVotes != null ? GlobalVariables.BureauVotes!.Description : "",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Color(0xffffffff),
                      ),
                    ),
                    SizedBox(height: 5, width: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        investType(data: (homme).toString(), text: "Homme"),
                        investType(data: (femme).toString(), text: "Femme"),
                        investType(data: (homme + femme).toString(), text: "Total"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Space(16),
            homeTitleMathWidget(
              titleText: "Comptage des participants",
            ),
            Space(16),
            SizedBox(
              height: 130,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  2,
                  (index) => GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Save('Homme');
                        setState(() {
                          homme++;
                          listePersonnes.add('Homme');
                        });
                      } else {
                        Save('Femme');
                        setState(() {
                          femme++;
                          listePersonnes.add('Femme');
                        });
                      }

                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                width: 160,
                                height: 100,
                                child: Image.asset(
                                    renovateServices[index].imagePath!,
                                    fit: BoxFit.cover),
                              )),
                          Space(8),
                          Text(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            renovateServices[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            homeTitleMathWidget(
              titleText: "Historiques",
            ),
            Space(16),
            Expanded(
              child: ListView.builder(
                itemCount: listePersonnes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(listePersonnes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  void Save(String sexe) async {
    try {


      GlobalVariables.showWaitDialog(context);
      final Map<String, String> header = {
        'content-type': '	application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + GlobalVariables.token,
      };

      VotesTaux data = new VotesTaux();
      data.description = sexe;
      data.quantite = 1;
      data.typeOperations = "TAUX";
      data.sexe = sexe;
      data.typeVotes = "";

      var encodeData = json.encode(data);

      final response = await http
          .post(Uri.parse(GlobalVariables.apiurl + 'Votes'), headers: header, body: encodeData);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        var responseData = json.decode(response.body);
        Navigator.pop(context);

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


}
