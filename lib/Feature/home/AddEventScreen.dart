import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/Model/EventModel.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/CustomButton.dart';
import 'package:localization/core/utils/FirebaseUtils.dart';
import 'package:localization/core/widget/TapEvents.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  var TitleController = TextEditingController();
  var DescriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  EventType selectedEvent = EventType.all;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    List<EventType> eventsTypeList = EventType.values;

    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light
          ? AppColors.whiteColor
          : Colors.black,

      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? AppColors.primaryLight
            : AppColors.primaryDark,
        title: Text(
          AppLocalizations.of(context)!.addEvent,
          style: TextStyle(
            color: themeProvider.appTheme == ThemeMode.light
                ? AppColors.whiteColor
                : AppColors.primaryLight,
            fontSize: 23,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Birthday.png"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    // color: themeProvider.appTheme == ThemeMode.light ? AppColors.transparentColor : AppColors.primaryLight ,
                    width: 2,
                  ),
                ),
              ),
              SizedBox(height: 10),
              DefaultTabController(
                length: eventsTypeList.length,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                      selectedEvent = eventsTypeList[index];
                    });
                  },
                  indicatorColor: AppColors.transparentColor,
                  dividerColor: AppColors.transparentColor,
                  labelColor: AppColors.whiteColor,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  tabAlignment: TabAlignment.start,

                  tabs: eventsTypeList.map((eventType) {
                    return Tab(
                      child: TapEvents(
                        eventName: getEventLabel(context, eventType),
                        isSelected:
                            selectedIndex == eventsTypeList.indexOf(eventType),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Padding(padding: const EdgeInsets.only(top: 15)),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryLight,
                      controller: TitleController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.title,
                        labelStyle: TextStyle(
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.primaryLight,
                          fontSize: 18,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                            width: 2,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primaryLight,
                            width: 2,
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: TextStyle(
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.blackColor
                            : AppColors.primaryLight,
                        fontSize: 18,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.length < 3) {
                            return "Invalid Title, too short";
                          }
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),

                    TextFormField(
                      cursorColor: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryLight,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.description,
                        labelStyle: TextStyle(
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.primaryLight,
                          fontSize: 18,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                            width: 2,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.primaryLight,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primaryLight,
                            width: 2,
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      maxLines: 3,
                      controller: DescriptionController,
                      style: TextStyle(
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.blackColor
                            : AppColors.primaryLight,
                        fontSize: 18,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.length < 10) {
                            return "Invalid Description, too short";
                          }
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.blackColor
                        : AppColors.primaryLight,
                  ),
                  SizedBox(width: 20),

                  Text(
                    AppLocalizations.of(context)!.date,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryLight,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                      // showDatePicker(
                      //   context: context,
                      //   firstDate: DateTime.now(),
                      //   initialDate: DateTime.now(),
                      //   lastDate: DateTime(2026),
                      // ).then((value) {
                      //   if (value != null)
                      //     DateController.text = DateFormat(
                      //       "dd/MMM",
                      //     ).format(value);
                      // });
                    },
                    child: selectedDate == null
                        ? Text(
                            AppLocalizations.of(context)!.chooseDate,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryLight,
                            ),
                          )
                        : Text(
                            DateFormat('dd/MM/yyyy').format(selectedDate!),
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryLight,
                            ),
                          ),
                  ),
                ],
              ),

              SizedBox(height: 25),

              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.blackColor
                        : AppColors.primaryLight,
                  ),
                  SizedBox(width: 20),

                  Text(
                    AppLocalizations.of(context)!.time,
                    style: TextStyle(
                      fontSize: 18,
                      color: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryLight,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      var chooseTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        selectedTime = chooseTime;
                      });
                    },

                    child: selectedTime == null
                        ? Text(
                            AppLocalizations.of(context)!.chooseTime,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryLight,
                            ),
                          )
                        : Text(
                            // selectedTime!.format(context),
                            DateFormat('hh:mm a').format(DateTime(
                                0, 0, 0, selectedTime!.hour, selectedTime!.minute)),
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryLight,
                            ),
                          ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryLight, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        border: Border.all(color: AppColors.primaryLight),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.location_searching,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.whiteColor
                            : AppColors.primaryDark,
                      ),
                    ),

                    SizedBox(width: 20),
                    Text(
                      AppLocalizations.of(context)!.chooseLocation,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    Spacer(),

                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryLight,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              CustomButton(
                width: double.infinity,
                txt: AppLocalizations.of(context)!.addEvent,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await AddEvent();
                    Navigator.pushNamed(context, '/');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> AddEvent() async {
    final date = selectedDate ?? DateTime.now();
    final time = selectedTime ?? TimeOfDay(hour: 0, minute: 0);

    final fullDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    var event = EventModel(
      title: TitleController.text,
      description: DescriptionController.text,
      dateTime: fullDateTime,
      // time: selectedTime!.format(context),
      eventName: selectedEvent,
    );

    try {
      await FirebaseUtils.addEventToFirestore(event);
    } catch (e) {
      print("Error adding event : $e");
    }
  }

  String getEventLabel(BuildContext context, EventType type) {
    switch (type) {
      case EventType.all:
        return AppLocalizations.of(context)!.all;
      case EventType.sports:
        return AppLocalizations.of(context)!.sports;
      case EventType.birthday:
        return AppLocalizations.of(context)!.birthday;
      case EventType.games:
        return AppLocalizations.of(context)!.games;
      case EventType.meeting:
        return AppLocalizations.of(context)!.meeting;
      case EventType.workshop:
        return AppLocalizations.of(context)!.workshop;
      case EventType.eating:
        return AppLocalizations.of(context)!.eating;
    }
  }
}
