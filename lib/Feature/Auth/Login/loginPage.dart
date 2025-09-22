import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:firebase_auth/firebase_auth.dart';

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
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isReObscure = true;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.welcome,
          style: TextStyle(fontSize: 23, fontFamily: 'poppins'),
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: Path != null
                      ? FileImage(File(Path!))
                      : NetworkImage("http://picsum.photos/200"),
                ),
                SizedBox(height: 10),

                SizedBox(height: 30),

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          } else if (!RegExp(
                            r'^[a-zA-Z]{2,8}@[a-z]{2,8}\.[a-z]{2,5}',
                          ).hasMatch(value)) {
                            return "Email must be in the format: name@domain.com";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Password is required";
                          } else if (!RegExp(
                            '^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$',
                          ).hasMatch(value)) {
                            return "Password must be 8+ chars with letters & numbers";
                          }
                          return null;
                        },
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.primaryLight,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        obscureText: isObscure,
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        // keyboardType: TextInputType.number,
                      ),

                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
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
                        ),
                      ),
                      SizedBox(height: 25),
                      CustomButton(
                        width: double.infinity,
                        txt: "Login",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Login();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Login() async {
    if (formKey.currentState!.validate()){

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'user-not-found':
          msg = 'No user found for that email.';
          break;
        case 'wrong-password':
          msg = 'Wrong password.';
          break;
        default:
          msg = 'Login failed. Please try again.';
      }
      print(msg);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryLight,
          content: Text(msg),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  }
}
