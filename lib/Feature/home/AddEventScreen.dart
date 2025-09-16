import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/Feature/home/homePage.dart';
import 'package:localization/Model/EventModel.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/TextStyle.dart';
import 'package:localization/core/utils/CustomButton.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  var formKey = GlobalKey<FormState>();
  var TitleController = TextEditingController();
  var DateController = TextEditingController(
    text: DateFormat("dd/MMM").format(DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    var eventsList = <EventModel>[];
    
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : Colors.black,
      
      appBar: AppBar(
      backgroundColor: themeProvider.appTheme == ThemeMode.light ? AppColors.primaryLight : AppColors.primaryDark,
        title: Text(
          AppLocalizations.of(context)!.addEvent,
          style: getTitleTextStyle(
            Color: themeProvider.appTheme == ThemeMode.light ? AppColors.whiteColor : AppColors.primaryLight, 
            fontSize: 23),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.name,
                    style: getBodyTextStyle(Color: AppColors.primaryLight),
                  ),
                  TextFormField(
                    cursorColor: AppColors.primaryLight,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryLight),
                      ),
                    ),

                    controller: TitleController,
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 4) {
                          return AppLocalizations.of(context)!.enterTitle;
                        }
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.date,
                    style: getBodyTextStyle(Color: AppColors.primaryLight),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    cursorColor: AppColors.primaryLight,

                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryLight),
                      ),
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now(),
                        lastDate: DateTime(2026),
                      ).then((value) {
                        if (value != null)
                          DateController.text = DateFormat(
                            "dd/MMM",
                          ).format(value);
                      });
                    },
                    readOnly: true,
                    controller: DateController,
                    
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        txt: AppLocalizations.of(context)!.addEvent,
                        width: 150,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Parse time using DateFormat
                            DateFormat format = DateFormat("dd/MMM");

                            EventModel NewEvent = EventModel(
                              Id:
                                  DateTime.now().toString() +
                                  TitleController.text,
                              Title: TitleController.text,
                              Date: DateController.text,                              
                            );

                            eventsList.add(NewEvent);
                            
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomePage();
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
