import 'package:flutter/material.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/widget/EventItemWidget.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : Colors.black,
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
        title: Text(AppLocalizations.of(context)!.favorites,
        style: TextStyle(
            color: themeProvider.appTheme == ThemeMode.light
                ? AppColors.whiteColor
                : AppColors.primaryLight,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins'
          ),
        ),
      ),
      body: 
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
                width: 2
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.search,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
                  size: 30
                 ),
                  SizedBox(width: 10,),
                  Text(AppLocalizations.of(context)!.searchEvent,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight
                  ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return EventItemWidget();
              },
            ),
          ),
        ],
      ),
    );  
  }
}