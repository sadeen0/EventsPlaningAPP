import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localization/core/utils/AppColors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.whiteColor,
      // color: AppColors.primaryLight,
      // iconTheme: IconThemeData(color: AppColors.blackColor),
      // titleTextStyle: TextStyle(
      //   color: Colors.black,
      //   fontWeight: FontWeight.w500,
      //   fontSize: 25,
      // ),
    ), 

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, // Fixed for more than 3 items, shifting for 3 or less items
      backgroundColor: AppColors.primaryLight,
      selectedItemColor: AppColors.yellowColor,
      unselectedItemColor: AppColors.whiteColor
    ), 
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: AppColors.whiteColor,
      
    )
  );



  static final ThemeData darkTheme = ThemeData(
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.primaryLight,
      // color: AppColors.primaryDark,
      // iconTheme: IconThemeData(color: AppColors.whiteColor),
      // titleTextStyle: TextStyle(
      //   color: Colors.white,
      //   fontWeight: FontWeight.w500,
      //   fontSize: 25,
      // ),
    ),  
      
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryDark,
      selectedItemColor: AppColors.yellowColor,
      unselectedItemColor: AppColors.primaryLight
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.whiteColor
    )
  );
}
