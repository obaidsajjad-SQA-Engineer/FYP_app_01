// ignore_for_file: prefer_const_constructors, dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/pages/directlygotowelcome.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //you can code here about splashscreen here
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
            print("If User, management!!!");
          }
          //you can code here where to move if already logged in.
          if (snapshot.hasData) {
            print("If # 02 User, management!!!");
            return DirectlyGoToWelcome(
              nextScreen: 'login',
            );
            //shared pref bool value 1
          } else {
            print("Else User, management!!!");
            return DirectlyGoToWelcome(
              nextScreen: 'notlogin',
            );
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [
                    Color.fromRGBO(235, 60, 22, 1),
                    Color.fromRGBO(246, 120, 13, 1),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sympto\n",
                            style: TextStyle(
                              fontSize: 70.w,
                              fontFamily: "font01",
                              color: Colors.white,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              height: 70.h,
                            ),
                          ),
                          TextSpan(
                            text: "Doc",
                            style: TextStyle(
                              fontSize: 80.w,
                              fontFamily: "font01",
                              color: Colors.white,
                              height: 0.7.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(35, 35, 30, 0),
                      child: Image.asset(
                        "assets/images/splash.png",
                        width: 220.w,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'MEDICAL\n',
                          style: TextStyle(
                            fontSize: 40.w,
                            fontFamily: "font02",
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(245, 114, 0, 1),
                          ),
                        ),
                        TextSpan(
                          text: 'APPLICATION\n',
                          style: TextStyle(
                            fontSize: 40.w,
                            fontFamily: "font02",
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(245, 114, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
