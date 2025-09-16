import 'package:flutter/material.dart';
import 'package:localization/core/utilis/AppColors.dart';
import 'package:localization/core/widget/EventItemWidget.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:localization/core/widget/TabEventWidget.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                ),
                SizedBox(height: 2),
                Text(
                  " Sadeen",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
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
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "En",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
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
                      color: AppColors.whiteColor,
                      size: 24,
                    ),
                    Text(
                      "Jerusalem, Palestine",
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 18,
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
              itemCount: 25,
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
