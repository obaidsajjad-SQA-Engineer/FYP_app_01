// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/accountmanagement/login.dart';
import 'package:patient_app/pages/accountmanagement/phonenovarification.dart';
import 'package:patient_app/pages/constants.dart';
import 'package:patient_app/pages/auth and management/authentication.dart';

final signupFormKey = GlobalKey<FormState>();
bool passShown = false;
var passIcon = const Icon(Icons.visibility);
final emailController = TextEditingController();
final passController = TextEditingController();
final nameController = TextEditingController();

final AuthenticationHelper authenticationHelper = AuthenticationHelper();

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: signupFormKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 45.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 34.h,
                          fontWeight: FontWeight.bold,
                          color: backgroundColor,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 45.w),
                        child: Text(
                          "Create an account to access all the features of SymptoDoc!",
                          softWrap: true,
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30.h,
                        ),
                        child: Text(
                          "Email",
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Image.asset(
                                "assets/images/attherate.png",
                                color: backgroundColor,
                              ),
                              hintText: "Ex: abc@example.com",
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontStyle: FontStyle.italic,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                borderSide: BorderSide(
                                  color: backgroundColor,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Your Name",
                        style: TextStyle(fontSize: 14.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: backgroundColor,
                              ),
                              hintText: "Ex. Obaid Sajjad",
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontStyle: FontStyle.italic,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                borderSide: BorderSide(
                                  color: backgroundColor,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Your Password",
                        style: TextStyle(fontSize: 14.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 30.h,
                        ),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextField(
                            controller: passController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: backgroundColor,
                              ),
                              hintText: "**********",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                borderSide: BorderSide(
                                  color: backgroundColor,
                                  width: 2.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      minimumSize: Size(340.w, 55.h),
                    ),
                    onPressed: () async {
                      if (emailController.text != "" &&
                          passController.text != "" &&
                          nameController.text != "") {
                        _showVerificationDialog(context);
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 14.h,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.h,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Login());
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.h,
                            color: buttonColor,
                          ),
                        ),
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
}

void _showVerificationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Verification Method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                minimumSize: Size(340.w, 55.h),
              ),
              onPressed: () {
                _showRegisterDialog(context);
              },
              child: Text('Email Verification'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                minimumSize: Size(340.w, 55.h),
              ),
              onPressed: () {
                Get.to(() => PhoneNumberVerification());
              },
              child: Text('Phone Number Verification'),
            ),
          ],
        ),
      );
    },
  );
}

void _showRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Check Email",
            style: TextStyle(
              fontSize: 34.h,
              fontWeight: FontWeight.bold,
              color: buttonColor,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
              "We have sent an email to your email account with a verification Link!"),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "NOTE: Try signing up again if you did'nt get the link!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              minimumSize: Size(360.w, 55.h),
            ),
            onPressed: () {
              //this must execute if user enters correct otp
              authenticationHelper.signUp(
                  email: emailController.text,
                  password: passController.text,
                  name: nameController.text,
                  role: "Patient");
              Get.to(() => Login());
            },
            child: Text(
              "Continue",
              style: TextStyle(
                fontSize: 14.h,
              ),
            ),
          ),
        ],
      ));
    },
  );
}
