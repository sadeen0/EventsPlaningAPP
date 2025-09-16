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
        title: Text(AppLocalizations.of(context)!.appTitle,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
        ),
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.lg,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryDark : AppColors.primaryLight
          ),
          ),
          DropdownButton(
            dropdownColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryDark,
            value: languageProvider.appLanguage,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
            color: AppColors.primaryLight),
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

          Text(AppLocalizations.of(context)!.theme,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryDark : AppColors.primaryLight
          ),),
          DropdownButton(
            dropdownColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryDark,
            value: themeProvider.appTheme,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
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
        ],
      ),
//      bottomNavigationBar: ProfilePage(),
    );
  }
}