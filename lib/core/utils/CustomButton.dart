import 'package:flutter/material.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/TextStyle.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? BgColor;
  final Color? txtColor;
  final String txt;
  final Function() onPressed;

  const CustomButton({
    super.key,
    this.width = 250,
    this.height = 50,
    required this.txt,
    this.BgColor,
    this.txtColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed, 
      child: Text(txt,
      style: getBodyTextStyle(
      Color: txtColor ?? (themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryDark),
      fontSize: 18,
      fontWeight: FontWeight.bold
      ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: BgColor ?? AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
      ),
    );
  }
}