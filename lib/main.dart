import 'package:flutter/material.dart';
import 'package:localization/Feature/home/homePage.dart';
import 'package:localization/core/providers/appLanguage_Provider.dart';
import 'package:localization/core/theme/AppTheme.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AppThemeProvider()),
        ChangeNotifierProvider(create: (context)=> AppLanguageProvider()),
      ],
      child: MainApp(),
    )
  ); 
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context); // object of class 
    var themeProvider = Provider.of<AppThemeProvider>(context); 

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: themeProvider.appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(languageProvider.appLanguage),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}
