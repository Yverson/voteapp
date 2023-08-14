import 'package:flutter/material.dart';
import 'package:voteapp/screens/active_bookings_screen.dart';
import 'package:voteapp/screens/booking_history_screen.dart';
import 'package:voteapp/screens/litige_history_screen.dart';
import 'package:voteapp/utils/colors.dart';

class BookingsFragment extends StatefulWidget {
  final bool fromProfile;

  const BookingsFragment({Key? key, required this.fromProfile}) : super(key: key);

  @override
  State<BookingsFragment> createState() => _BookingsFragmentState();
}

class _BookingsFragmentState extends State<BookingsFragment> with SingleTickerProviderStateMixin {
  late TabController bookingTabController = TabController(length: 3, vsync: this, initialIndex: 0);

  @override
  void dispose() {
    super.dispose();
    bookingTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        leading: Visibility(
          visible: widget.fromProfile ? true : false,
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Validation"
              "",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        bottom: TabBar(
          controller: bookingTabController,
          labelStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          indicatorColor: blackColor,
          tabs: [
            Tab(text: "Validation"),
            Tab(text: "Historiques"),
            Tab(text: "Litiges"),
          ],
        ),
      ),
      body: TabBarView(
        controller: bookingTabController,
        children: [
          ActiveBookingsScreen(),
          BookingHistoryScreen(),
          LitigeHistoryScreen(),
        ],
      ),
    );
  }
}
