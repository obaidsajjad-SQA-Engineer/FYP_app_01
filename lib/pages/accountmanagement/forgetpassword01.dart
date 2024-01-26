// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/accountmanagement/register.dart';
import 'package:patient_app/pages/auth%20and%20management/authentication.dart';
import 'package:patient_app/pages/constants.dart';

import 'login.dart';

final AuthenticationHelper authenticationHelper = AuthenticationHelper();

class ForgetPassword01 extends StatelessWidget {
  const ForgetPassword01({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      height: 100.h,
                    ),
                    Text(
                      "Forgot Password?",
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
                        "Recover you password if you have forgot the password!",
                        softWrap: true,
                        style: TextStyle(fontSize: 16.h),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 30.h,
                        ),
                        child: Text(
                          "Verification code",
                          style: TextStyle(fontSize: 16.h),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 45.w,
                        top: 5.h,
                        bottom: 30.h,
                      ),
                      child: Container(
                        width: 360.w,
                        height: 55.h,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(),
                            prefixIcon:
                                Image.asset("assets/images/attherate.png"),
                            prefixStyle: TextStyle(
                              color: backgroundColor,
                              fontSize: 12.h,
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 45.w, right: 45.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: Size(360.w, 55.h),
                  ),
                  onPressed: () async {
                    try {
                      String? result =
                          await authenticationHelper.forgotPassword(
                              email: emailController.text.toString());
                      if (result == null) {
                        _showForgetDialog(context);
                        // Password reset email sent successfully
                      } else {
                        // Handle the error
                        print('Error: $result');
                      }
                    } catch (e) {
                      // Handle exceptions
                      print('Exception: $e');
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 14.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showForgetDialog(BuildContext context) {
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
            "NOTE: Try Forget Password again if you did'nt get the link!",
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
