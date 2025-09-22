import 'package:flutter/material.dart';
import 'package:localization/core/utils/AppColors.dart';

typedef MyValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  final Color? color;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final int? maxLines;
  final MyValidator? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    required this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.controller,
    this.maxLines,
    super.key,
    this.color,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorStyle: TextStyle(
          color: AppColors.redColor,
          fontSize: 11,
        ),
      ),
    );
  }
}
