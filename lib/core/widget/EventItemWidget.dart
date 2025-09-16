import 'package:flutter/material.dart';
import 'package:localization/core/utilis/AppColors.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
      ),
      margin: EdgeInsets.only(bottom: 20),
      height: 260,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/Birthday.png"), 
        fit: BoxFit.fill
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteColor
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("22",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryLight
                  ),
                ),
                Text("Feb",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryLight
                  ),
                )
              ],
            ),
           )
  
    
          
        ],
      ),
    );
  }
}