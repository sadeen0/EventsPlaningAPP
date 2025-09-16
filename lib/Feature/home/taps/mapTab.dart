import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:provider/provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : Colors.black,
      body: Center(
        child: Text("Map Tab",
          style: TextStyle(
            fontSize: 24,
            color: themeProvider.appTheme == ThemeMode.light ? AppColors.blackColor : AppColors.primaryLight,
          ),
        ),
      ),
    );
  }
}