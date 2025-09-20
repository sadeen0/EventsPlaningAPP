import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/Feature/home/EditEvent.dart';
import 'package:localization/Model/EventModel.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/FirebaseUtils.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatelessWidget {

  final EventModel event;
  final VoidCallback onFavoriteToggle;
  EventItemWidget({super.key, required this.event, required this.onFavoriteToggle});

  
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
      ),
      margin: EdgeInsets.only(bottom: 20),
      height: 260,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/Birthday.png"), 
        fit: BoxFit.fill
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
         //color: themeProvider.appTheme == ThemeMode.light ? AppColors.transparentColor : AppColors.primaryLight ,
          width: 2
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.dateTime.day.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark
                  ),
                ),
                Text(
                  DateFormat('MMM').format(
                    event.dateTime
                  ),

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark
                  ),
                )
              ],
            ),
           ),
           Spacer(),
           Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight
            ),
            child: Row(
              children: [
                Text(event.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark
                  ),
                ),
                Spacer(),

                IconButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditEventPage(event: event)));
                  },
                  
                  icon:Icon( Icons.edit,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
                   ),
                   
                ),

                
                 IconButton(
                  onPressed: () async {
                    await FirebaseUtils.updateFavorite(event.id, !event.isFavorite);
                    onFavoriteToggle();
                  },
                  icon:Icon( event.isFavorite
                     ? Icons.favorite
                     : Icons.favorite_border_outlined,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
                   ),
                   
                ),
               ],
            ),
           ) 
        ],
      ),
    );
  }
}