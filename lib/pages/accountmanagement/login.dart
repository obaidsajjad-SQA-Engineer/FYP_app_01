// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/Patient/startdiagnosis.dart';
import 'package:patient_app/pages/accountmanagement/register.dart';
import 'package:patient_app/pages/auth%20and%20management/authentication.dart';
import 'package:patient_app/pages/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgetpassword01.dart';

final AuthenticationHelper authenticationHelper = AuthenticationHelper();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginFormKey = GlobalKey<FormState>();
  bool passShown = false;
  var passIcon = const Icon(Icons.visibility);
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String? email;
  String? password;
  bool _isHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 45.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      Text(
                        "Login",
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
                          "Unlocking health, empowering lives: seamless access to compassionate care in every click",
                          softWrap: true,
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Email",
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Image.asset(
                                "assets/images/attherate.png",
                              ),
                              prefixStyle: TextStyle(
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
                            onSaved: (newValue) {
                              email = newValue;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Your Password",
                        style: TextStyle(fontSize: 14.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 45.w, top: 5.h),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextFormField(
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: backgroundColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: _togglePasswordVisibility,
                                icon: _isHidden
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: backgroundColor,
                                      ),
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
                            onSaved: (newValue) {
                              password = newValue;
                            },
                            controller: passController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ForgetPassword01());
                          },
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: backgroundColor,
                                fontSize: 14.h),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              minimumSize: Size(360.w, 55.h),
                            ),
                            onPressed: () async {
                              if (await authenticationHelper.logIn(
                                    email: emailController.text,
                                    password: passController.text,
                                  ) ==
                                  1) {
                                final SharedPreferences isLoggedIn =
                                    await SharedPreferences.getInstance();

                                await isLoggedIn.setBool('login', true);
                                Get.offAll(() => StartDiagnosis());
                                emailController.clear();
                                passController.clear();
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 14.h),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: Divider(
                          color: Colors
                              .black, // Set the color of the line (optional)
                          height: 1, // Set the height of the line (optional)
                          thickness:
                              1, // Set the thickness of the line (optional)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10.h, 45.w, 0),
                        child: MaterialButton(
                          minWidth: 360.w,
                          height: 55.h,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
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
                                width: 10.w,
                              ),
                              Text(
                                "Continue with Google",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                        "Don't have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.h,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Register());
                        },
                        child: Text(
                          " Register",
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
