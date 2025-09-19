import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localization/Feature/home/homePage.dart';
import 'package:localization/core/providers/appTheme_Provider.dart';
import 'package:localization/core/utils/AppColors.dart';
import 'package:localization/core/utils/CustomTextField.dart';
import 'package:localization/core/utils/TextStyle.dart';
import 'package:localization/l10n/app_localizations.dart';
import 'package:localization/core/utils/CustomButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? Path;
  final ImagePicker picker = ImagePicker();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        //title: Text(AppLocalizations.of(context)!.welcome,),
        title: Text(
          "Welcome",
          style: TextStyle(fontSize: 23, fontFamily: 'poppins'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate() && Path != null) {
                  var Box = await Hive.openBox('user');
                  var UserBox = Hive.box('user');
                  UserBox.put('name', nameController.text);
                  UserBox.put('image', Path);
                  UserBox.put("IsUpoloaded", true);
                  //print('Name is ${nameController.text}');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else if (Path == null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Error",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        content: Text(
                          "Please Upload Image!",
                          style: getBodyTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                "Done",
                style: getSmallTextStyle(
                  Color: AppColors.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            ///mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: Path != null
                    ? FileImage(File(Path!))
                    : NetworkImage("http://picsum.photos/200"),
              ),
              SizedBox(height: 10),
              CustomButton(
                txt: "Upload From Camera",
                onPressed: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.camera)
                      .then((value) {
                        if (value != null) {
                          setState(() {
                            Path = value.path;
                          });
                        }
                      });
                },
              ),
              SizedBox(height: 15),

              CustomButton(
                txt: "Upload From Gallery",
                onPressed: () async {
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (image != null) {
                    setState(() {
                      Path = image.path;
                    });
                  }
                },
              ),
              SizedBox(height: 15),
              Divider(
                color: AppColors.primaryLight,
                indent: 20,
                endIndent: 20,
                thickness: 2,
              ),

              SizedBox(height: 30),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        } else if (!RegExp(
                          '^[A-Z][a-z]{2,7}',
                        ).hasMatch(value)) {
                          return "Name must start with a capital letter and be 3-7 letters long";
                        }
                        return null;
                      },
                      controller: nameController,

                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.primaryLight,
                      ),
                      hintText: "Enter Your Name",
                      labelText: AppLocalizations.of(context)!.personName,
                      labelStyle: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: 20),
                    CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(
                          '^[a-z]{2,8}@[a-z]{2,8}\.[a-z]{2,5}',
                        ).hasMatch(value)) {
                          return "Email must be in the format: name@domain.com";
                        }
                        return null;
                      },
                      controller: emailController,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.primaryLight,
                      ),
                      hintText: AppLocalizations.of(context)!.enterEmail,
                      labelText: AppLocalizations.of(context)!.email,
                      labelStyle: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        } else if (!RegExp(
                          '^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$',
                        ).hasMatch(value)) {
                          return "Password must be 8+ chars with letters & numbers";
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintText: AppLocalizations.of(context)!.enterPassword,
                      labelText: AppLocalizations.of(context)!.password,
                      labelStyle: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 18,
                      ),
                      //obscureText: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.primaryLight,
                      ),
                      
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: AppColors.primaryLight,
                      ),
                      
                    ),
                    
                    SizedBox(height: 10),
                    Text(
                      "Forgot Password?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.primaryLight
                            : AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            themeProvider.appTheme == ThemeMode.light
                            ? AppColors.primaryLight
                            : AppColors.whiteColor,
                        decorationThickness: 1.5,
                      
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
