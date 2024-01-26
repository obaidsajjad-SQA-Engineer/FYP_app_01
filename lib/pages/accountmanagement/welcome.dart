// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/constants.dart';

import 'login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 45.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200.w,
                  ),
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 16.h,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    "SymptoDoc",
                    style: TextStyle(
                      fontSize: 34.h,
                      color: backgroundColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "A place where you can track all your",
                    style: TextStyle(
                      fontSize: 14.h,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    "health and find a doctor",
                    style: TextStyle(
                      fontSize: 14.h,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Lets get started",
                    style: TextStyle(
                      fontSize: 16.h,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.h, 45.h, 0),
                    child: MaterialButton(
                      minWidth: 360.w,
                      height: 55.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10
                            .h), // Optional, if you want to add some rounded corners to the border
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.w,
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google.png",
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Continue with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.h),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.h, 45.h, 0),
                    child: MaterialButton(
                      minWidth: 360.w,
                      height: 55.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10
                            .h), // Optional, if you want to add some rounded corners to the border
                        side: BorderSide(
                          color: Colors.black,
                          width: 2.w,
                        ),
                      ),
                      onPressed: () {},
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '@',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.h,
                                  color: backgroundColor,
                                ),
                              ),
                              TextSpan(
                                text: '  Continue with Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.h,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            Row(
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
                      color: backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
