import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localization/Model/EventModel.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/FirebaseUtils.dart';
import 'package:localization/core/widget/EventItemWidget.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List eventsList = [];

  void getFavEvents() async {
    Query<EventModel> query = await FirebaseUtils.getEventCollection().where(
      "isFavorite",
      isEqualTo: true,
    ); // get collection

    var event = await query.get();
    eventsList = event.docs.map((docs) {
      return docs.data();
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFavEvents();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light
          ? AppColors.whiteColor
          : Colors.black,
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? AppColors.primaryLight
            : AppColors.primaryDark,
        title: Text(
          AppLocalizations.of(context)!.favorites,
          style: TextStyle(
            color: themeProvider.appTheme == ThemeMode.light
                ? AppColors.whiteColor
                : AppColors.primaryLight,
            fontSize: 23,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: eventsList.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noFavoriteEvents,
          style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
              ),))
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryLight,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.search,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.primaryLight,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.searchEvent,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: eventsList.length,
                    itemBuilder: (context, index) {
                    return EventItemWidget(
                      event: eventsList[index],

                      onFavoriteToggle: getFavEvents,
                      
                    );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
