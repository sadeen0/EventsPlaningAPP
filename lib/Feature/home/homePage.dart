import 'package:flutter/material.dart';
import 'package:localization/Feature/home/AddEventScreen.dart';
import 'package:localization/Feature/home/taps/homeTab.dart';
import 'package:localization/Feature/home/taps/mapTab.dart';
import 'package:localization/Feature/home/taps/favoriteTab.dart';
import 'package:localization/Feature/home/taps/profileTab.dart';
import 'package:localization/core/providers/appLanguage_Provider.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/theme/AppTheme.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int selectedIndex = 0;
  final List<Widget> taps = [HomeTab(), MapTab(), FavoriteTab(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(      
      body: taps[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddEventScreen();
              },
            ),
          );
        },
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : Colors.black, width: 6),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(Icons.add, size: 30,
        color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          //print(index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: AppLocalizations.of(context)!.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.favorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      // appBar: AppBar(
      //   title: Text(
      //     AppLocalizations.of(context)!.appTitle,
      //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
      //   ),
      // ),
    );
  }
}
