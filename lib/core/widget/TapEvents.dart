import 'package:flutter/material.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:provider/provider.dart';

class TapEvents extends StatelessWidget {
  TapEvents({super.key, required this.eventName, required this.isSelected});

  String eventName;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
       // color: isSelected ? AppColors.whiteColor : AppColors.transparentColor,
        color: isSelected ? themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryLight
        : AppColors.transparentColor,
        border: Border.all(
          color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryLight,
          width: 2
        ),
       borderRadius: BorderRadius.circular(20),
     ),
     child: Text(eventName,
       style: TextStyle(
        // color: isSelected ? AppColors.primaryLight : AppColors.whiteColor,
        color: isSelected ? themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryDark
         : themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryLight,
         fontSize: 16,
         fontWeight: FontWeight.bold,
       ),
     )
    );
  }
}