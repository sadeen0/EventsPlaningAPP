import 'package:flutter/material.dart';
import 'package:localization/core/providers/appLanguage_Provider.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
        ),
        ),
        
      ),
      body: Column(
        children: [
          Text(AppLocalizations.of(context)!.lg),
          DropdownButton(
            value: languageProvider.appLanguage,
            isExpanded: true,
            padding: const EdgeInsets.all(15),
            items: [
              DropdownMenuItem(value: 'ar', child: Text(AppLocalizations.of(context)!.ar)),
              DropdownMenuItem(value: 'en', child: Text(AppLocalizations.of(context)!.en)),
            ],
            onChanged: (value) {
              languageProvider.changeLanguage(value.toString());
            },
            //hint: Text('Select Language'),
          ),

          Text(AppLocalizations.of(context)!.theme),
          DropdownButton(
            value: themeProvider.appTheme,
            isExpanded: true,
            padding: const EdgeInsets.all(15),
            items: [
              DropdownMenuItem(value: ThemeMode.dark, child: Text(AppLocalizations.of(context)!.dark)),
              DropdownMenuItem(value: ThemeMode.light, child: Text(AppLocalizations.of(context)!.light)),
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
      bottomNavigationBar: ProfilePage(),
    );
  }
}