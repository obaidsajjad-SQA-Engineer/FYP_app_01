// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/pages/Patient/startdiagnosis.dart';
import 'package:patient_app/pages/accountmanagement/login.dart';
import 'package:patient_app/pages/accountmanagement/welcome.dart';

import '../main.dart';
import 'onboardingscreens/onboardingscreen01.dart';

class DirectlyGoToWelcome extends StatefulWidget {
  const DirectlyGoToWelcome({super.key, required this.nextScreen});
  final String nextScreen;
  @override
  _DirectlyGoToWelcomeState createState() => _DirectlyGoToWelcomeState();
}

class _DirectlyGoToWelcomeState extends State<DirectlyGoToWelcome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.nextScreen == "login") {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return onboardingShown
                ? loginShown == false
                    ? Login()
                    : StartDiagnosis()
                : Onboardingscreen01();
          }),
        );
      });
    } else if (widget.nextScreen == "notlogin") {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return onboardingShown ? Welcome() : Onboardingscreen01();
          }),
        );
      });
    } else {}

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward().whenComplete(() {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Flex(
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
      ),
    );
  }
}
