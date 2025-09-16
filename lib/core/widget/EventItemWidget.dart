import 'package:flutter/material.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/theme/AppTheme.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

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
         // color: themeProvider.appTheme == ThemeMode.light ? AppColors.transparentColor : AppColors.primaryLight ,
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
                Text("22",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark
                  ),
                ),
                Text("Feb",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark
                  ),
                )
              ],
            ),
           )      
        ],
      ),
    );
  }
}