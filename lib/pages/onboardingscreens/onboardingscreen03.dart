// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_app/pages/accountmanagement/welcome.dart';
import 'package:patient_app/pages/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboardingscreen01.dart';

class Onboardingscreen03 extends StatefulWidget {
  const Onboardingscreen03({super.key});

  @override
  State<Onboardingscreen03> createState() => _Onboardingscreen03State();
}

class _Onboardingscreen03State extends State<Onboardingscreen03> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1000),
          pageBuilder: (context, animation, secondaryAnimation) =>
              Onboardingscreen01(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacityAnimation = animation.drive(tween);

            return FadeTransition(
              opacity: opacityAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -100.h,
              left: -150.w,
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.width * 1.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.width * 1.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(
                                0.882896900177002, 0.1717861294746399),
                            end: Alignment(
                                -0.1717861443758011, 0.1527906060218811),
                            colors: gradient,
                          ),
                          borderRadius: BorderRadius.all(Radius.elliptical(
                            MediaQuery.of(context).size.width * 0.80,
                            MediaQuery.of(context).size.width * 0.80,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 500.w,
                height: 1000.w,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 100.h,
                      left: 60.w,
                      child: Container(
                        child: Image.asset(
                          "assets/images/doc3.png",
                          width: 350.w,
                          height: 350.h,
                        ),
                        width: 300.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 540.h,
              left: 270.w,
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.width * 1.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.80,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.all(Radius.elliptical(
                              248.71920776367188, 248.71920776367188)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 550.h,
                      left: 60.w,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Your Health Control",
                              style: TextStyle(
                                  fontSize: 28.h,
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            Text(
                              "Take charge of your health with Sympto Doc. Detect diseases early, consult with experts, and stay on top of your well-being. Empowering you with knowledge and care, anytime, anywhere.",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.h,
                                  color: Color.fromARGB(255, 146, 146, 146),
                                  decoration: TextDecoration.none),
                            ),
                          ],
                        ),
                        width: 300.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 750.h,
                      left: 60.w,
                      child: Container(
                        child: MaterialButton(
                          color: backgroundColor,
                          height: 55.h,
                          minWidth: 360.w,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setBool('showHome', true);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Welcome(),
                              ),
                            );
                          },
                          child: Text(
                            "Get Started",
                            style:
                                TextStyle(fontSize: 16.h, color: Colors.white),
                          ),
                        ),
                        width: 300.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
