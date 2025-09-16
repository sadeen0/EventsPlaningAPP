import 'package:flutter/material.dart';
import 'package:localization/core/utils/AppColors.dart';

TextStyle getTitleTextStyle({double? fontSize, Color? Color, FontWeight? fontWeight} ){
  return TextStyle(
    fontSize: fontSize ?? 30,
    color: Color?? AppColors.primaryLight,
    fontWeight: fontWeight?? FontWeight.bold,
  );
}

TextStyle getSmallTextStyle({double? fontSize, Color? Color, FontWeight? fontWeight} ){
  return TextStyle(
    fontSize: fontSize ?? 24,
    color: Color?? AppColors.whiteColor,
    fontWeight: fontWeight?? FontWeight.bold,
  );
}

TextStyle getBodyTextStyle({double? fontSize, Color? Color, FontWeight? fontWeight} ){
  return TextStyle(
    fontSize: fontSize ?? 16,
    color: Color?? AppColors.blackColor,
    fontWeight: fontWeight?? FontWeight.bold,
  );
}