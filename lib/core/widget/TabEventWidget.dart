import 'package:flutter/material.dart';
import 'package:localization/core/utilis/AppColors.dart';

class TapEventWidget extends StatelessWidget {
  TapEventWidget({super.key, required this.eventName, required this.isSelected});

  String eventName;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.whiteColor : AppColors.transparentColor,
        border: Border.all(
          color: AppColors.whiteColor,
          width: 2
        ),
       borderRadius: BorderRadius.circular(20),
     ),
     child: Text(eventName,
       style: TextStyle(
         color: isSelected ? AppColors.primaryLight : AppColors.whiteColor,
         fontSize: 16,
         fontWeight: FontWeight.bold,
       ),
     )
    );
  }
}