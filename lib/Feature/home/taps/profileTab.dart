import 'package:flutter/material.dart';
import 'package:localization/core/providers/appLanguage_Provider.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : Colors.black,
      appBar: AppBar(
        toolbarHeight: 5, 
        ),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage('https://www.pngall.com/wp-content/uploads/5/Profile-PNG-File.png'),
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sadeen",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight
                    ),),
                    Text("sadeen@gmail.com",
                    style: TextStyle(
                      fontSize: 20,
                      color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight,
                      fontWeight: FontWeight.w500,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.lg,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryDark : AppColors.primaryLight
              ),
              ),
              SizedBox(height: 15,),
              Container(
                
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: DropdownButton(
                    underline: SizedBox(),
                    iconEnabledColor: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
                    dropdownColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryDark,
                    value: languageProvider.appLanguage,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight),
                    isExpanded: true,
                    padding: const EdgeInsets.all(20),
                    items: [
                      DropdownMenuItem(value: 'ar', child: Text(AppLocalizations.of(context)!.ar,
                      )),
                      DropdownMenuItem(value: 'en', child: Text(AppLocalizations.of(context)!.en,
                      )),
                    ],
                    onChanged: (value) {
                      languageProvider.changeLanguage(value.toString());
                    },
                    //hint: Text('Select Language'),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text(AppLocalizations.of(context)!.theme,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryDark : AppColors.primaryLight
              ),),
              SizedBox(height: 15,),
              
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: DropdownButton(
                  underline: SizedBox(),
                  iconEnabledColor: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
                  dropdownColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryDark,
                  value: themeProvider.appTheme,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight),
                  isExpanded: true,
                  padding: const EdgeInsets.all(20),
                  items: [
                    DropdownMenuItem(value: ThemeMode.dark, child: Text(AppLocalizations.of(context)!.dark,
                    )),
                    DropdownMenuItem(value: ThemeMode.light, child: Text(AppLocalizations.of(context)!.light,
                    )),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.changeTheme(value);
                    }
                    
                  },
                  //hint: Text('Select Theme'),
                ),
              ),
            ],
          ),
        ],
      ),
//      bottomNavigationBar: ProfilePage(),
    );
  }
}