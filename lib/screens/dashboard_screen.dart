import 'package:flutter/material.dart';
import 'package:voteapp/fragments/account_fragment.dart';
import 'package:voteapp/fragments/bookings_fragment.dart';
import 'package:voteapp/fragments/home_fragment.dart';
import 'package:voteapp/fragments/search_fragment.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime? _currentBackPressTime;

  final _pageItem = [
    HomeFragment(),
    SearchFragment(),
    BookingsFragment(fromProfile: false),
  ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          body: _pageItem[_selectedItem],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(size: 30, opacity: 1),
            unselectedIconTheme: IconThemeData(size: 28, opacity: 0.5),
            selectedLabelStyle: TextStyle(fontSize: 14),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            elevation: 40,
            selectedFontSize: 16,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 20),
                activeIcon: Icon(Icons.home_rounded, size: 20),
                label: "Taux de participation",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined, size: 20),
                activeIcon: Icon(Icons.account_balance_wallet, size: 20),
                label: "Depouillement",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined, size: 20),
                activeIcon: Icon(Icons.calendar_month_outlined, size: 20),
                label: "Validation",
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              _selectedItem = setValue;
              setState(() {});
            },
          ),
        ));
  }
}
