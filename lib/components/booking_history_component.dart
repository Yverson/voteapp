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

class BookingHistoryComponent extends StatelessWidget {
  List<Votes>? allVotes = [];
  final int index;

  BookingHistoryComponent(this.index, {this.allVotes});

  @override
  Widget build(BuildContext context) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var timeFormat = DateFormat('HH:mm');
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          color: appData.isDark ? cardColorDark : cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Divider(color: dividerColor, thickness: 1),
                Space(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.height * 0.07,
                        child: (allVotes![index].Photo != null && allVotes![index].Photo != "") ? Image.network(allVotes![index].Photo, fit: BoxFit.cover) : Image.asset(home, fit: BoxFit.cover) ,
                      ),
                    ),
                    Space(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(allVotes![index].description, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.clip,),
                        Space(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined, color: orangeColor, size: 16),
                            Space(2),
                            Text(outputFormat.format(allVotes![index].created! as DateTime), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Space(2),
                            Text("à", style: TextStyle(color: orangeColor, fontSize: 12)),
                            Space(2),
                            Text(timeFormat.format(allVotes![index].created! as DateTime), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        Space(2),
                        Text(allVotes![index].quantite.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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


}
