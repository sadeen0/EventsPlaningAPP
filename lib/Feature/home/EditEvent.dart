import 'package:flutter/material.dart';
import 'package:localization/Model/EventModel.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/CustomButton.dart';
import 'package:localization/core/utils/FirebaseUtils.dart';
import 'package:localization/core/widget/TapEvents.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditEventPage extends StatefulWidget {
  final EventModel event;
  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  late TextEditingController TitleController;
  late TextEditingController DescriptionController;
  final DateFormat timeFormat = DateFormat("hh:mm a");
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  EventType selectedEvent = EventType.all;

  @override
  void initState() {
    super.initState();
    TitleController = TextEditingController(text: widget.event.title);
    DescriptionController = TextEditingController(
      text: widget.event.description,
    );
    selectedDate = widget.event.dateTime;
    selectedEvent = widget.event.eventName;
    selectedTime = TimeOfDay(
      hour: widget.event.dateTime.hour,
      minute: widget.event.dateTime.minute,
    );
    // try {
    //   if (widget.event.time.isNotEmpty) {
    //     final parsedDate = timeFormat.parse(widget.event.time);
    //     selectedTime = TimeOfDay.fromDateTime(parsedDate);
    //   }
    // } catch (e) {
    //   selectedTime = TimeOfDay.now();
    // }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<EventType> eventsTypeList = EventType.values;
    // List<EventType> eventsNameList = [
    //   AppLocalizations.of(context)!.all,
    //   AppLocalizations.of(context)!.sports,
    //   AppLocalizations.of(context)!.birthday,
    //   AppLocalizations.of(context)!.games,
    //   AppLocalizations.of(context)!.meeting,
    //   AppLocalizations.of(context)!.workshop,
    //   AppLocalizations.of(context)!.eating,
    // ];

    // int index = eventsNameList.indexOf(selectedEvent);
    // selectedIndex = index != -1 ? index : 0;
    // selectedEvent = eventsNameList[selectedIndex];
    int index = eventsTypeList.indexOf(selectedEvent);
    selectedIndex = index != -1 ? index : 0;
    selectedEvent = eventsTypeList[selectedIndex];

    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light
          ? AppColors.whiteColor
          : Colors.black,

      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? AppColors.primaryLight
            : AppColors.primaryDark,
        title: Text(
          AppLocalizations.of(context)!.editEvent,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryLight,
                      ),
                      child: Text(
                        widget.event.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.whiteColor
                              : AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              DefaultTabController(
                //initialIndex: index,
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

                  tabs: eventsTypeList.map((eventName) {
                    return Tab(
                      child: TapEvents(
                        eventName: getEventLabel(context, eventName),
                        isSelected:
                            selectedIndex == eventsTypeList.indexOf(eventName),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Padding(padding: const EdgeInsets.only(top: 15)),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: TitleController,
                      cursorColor: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.primaryLight,
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
                    SizedBox(height: 30),

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
              SizedBox(height: 30),
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
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
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
                            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryLight,
                            ),
                          ),
                  ),
                ],
              ),

              SizedBox(height: 30),

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
                        initialTime: selectedTime ?? TimeOfDay.now(),
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
                            selectedTime!.format(context),
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryLight,
                            ),
                          ),
                  ),
                ],
              ),

              SizedBox(height: 30),

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
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 150,
                    txt: AppLocalizations.of(context)!.save,

                    onPressed: () async {
                      if (selectedDate == null || selectedTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please choose date and time"),
                            backgroundColor: AppColors.redColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      widget.event.title = TitleController.text;
                      widget.event.description = DescriptionController.text;
                      widget.event.dateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      // widget.event.dateTime = selectedDate!;
                      // widget.event.time = selectedTime!.format(context);
                      widget.event.eventName = selectedEvent;

                      if (formKey.currentState!.validate()) {
                        await EditEvent();
                        Navigator.pop(context, widget.event);
                      }
                    },
                  ),
                  SizedBox(width: 20),
                  CustomButton(
                    width: 150,
                    txt: AppLocalizations.of(context)!.deleteEvent,
                    onPressed: () async {
                      // show confirmation dialog
                      bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.deleteEvent,
                            ),
                            content: Text(
                              AppLocalizations.of(context)!.confirmDelete,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Confirm
                                },
                                child: Text(AppLocalizations.of(context)!.yes),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // Cancel
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      if (confirm == true) {
                        await DeleteEvent();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.eventDeleted,
                            ),
                            duration: Duration(seconds: 3),
                            backgroundColor: AppColors.greenColor,
                          ),
                        );
                        Navigator.pop(context, widget.event);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> EditEvent() async {
    final fullDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    widget.event.dateTime = fullDateTime;
    var event = EventModel(
      title: TitleController.text,
      description: DescriptionController.text,
      dateTime: fullDateTime,
      // time: selectedTime!.format(context),
      eventName: selectedEvent,
    );

    try {
      await FirebaseUtils.updateEventInFirestore(widget.event);
    } catch (e) {
      print("Error editing event : $e");
    }
  }

  Future<void> DeleteEvent() async {
    if (selectedDate == null || selectedTime == null) {
      print("Date or Time not selected");
      return;
    }

    final fullDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    try {
      await FirebaseUtils.DeleteEventFromFirestore(widget.event);
    } catch (e) {
      print("Error deleting event : $e");
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
