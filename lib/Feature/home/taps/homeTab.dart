import 'package:flutter/material.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/widget/EventItemWidget.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:localization/core/widget/TabEventWidget.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    List<String> events = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.games,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.eating,
    ];
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : Colors.black,

      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.welcome,
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                     color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,),
                  ),
                  SizedBox(height: 5),
                  Text(
                    " Sadeen",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.sunny),
                  SizedBox(width: 12),
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.lang,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryDark : AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 130,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,
                      size: 25,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${AppLocalizations.of(context)!.city}، ${AppLocalizations.of(context)!.country}",
                      style: TextStyle(
                        color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                DefaultTabController(
                  length: events.length,
                  child: TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    labelColor: AppColors.whiteColor,
                    isScrollable: true,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    tabAlignment: TabAlignment.start,

                    tabs: events.map((eventName) {
                      return Tab(
                        child: TapEventWidget(
                          eventName: eventName,
                          isSelected:
                              selectedIndex == events.indexOf(eventName),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
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
