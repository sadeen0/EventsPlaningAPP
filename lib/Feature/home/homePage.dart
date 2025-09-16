import 'package:flutter/material.dart';
import 'package:localization/Feature/home/taps/homeTab.dart';
import 'package:localization/Feature/home/taps/mapTab.dart';
import 'package:localization/Feature/home/taps/favoriteTab.dart';
import 'package:localization/Feature/home/taps/profileTab.dart';
import 'package:localization/core/utilis/AppColors.dart';
import 'package:localization/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Widget> taps = [
      HomeTab(),
      MapTab(),
      FavoriteTab(),
      ProfileTab(),
    ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: taps[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.whiteColor, width: 5), borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, size: 30),
      ),
      bottomNavigationBar:  BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
            
            //print(index);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.home),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: AppLocalizations.of(context)!.map),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: AppLocalizations.of(context)!.favorites),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: AppLocalizations.of(context)!.profile),
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
