import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/accountmanagement/login.dart';
import 'package:patient_app/pages/constants.dart';

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 45.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 34.h,
                    fontWeight: FontWeight.bold,
                    color: buttonColor,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("We have sent an email to your email"),
                Text("account with a verification code!"),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Verification code",
                  style: TextStyle(fontSize: 16.h),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 45.w,
                    top: 10.h,
                    bottom: 40.h,
                  ),
                  child: Container(
                    width: 360.w,
                    height: 55.h,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20.h),
                        hintText: "Ex: 1 2 3 4 5 6",
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
                Padding(
                  padding: EdgeInsets.only(right: 45.w),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      minimumSize: Size(360.w, 55.h),
                    ),
                    onPressed: () {
                      Get.to(() => Login());
                    },
                    child: Text("Register"),
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
