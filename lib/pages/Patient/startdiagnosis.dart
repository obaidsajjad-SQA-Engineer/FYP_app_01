// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/Patient/patientinformation.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

class StartDiagnosis extends StatefulWidget {
  const StartDiagnosis({super.key});

  @override
  State<StartDiagnosis> createState() => _StartDiagnosisState();
}

class _StartDiagnosisState extends State<StartDiagnosis> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      mainScreen: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppNotifications(),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Image.asset(
                  images[0],
                  height: 300.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 480.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          50.r,
                        ),
                        topRight: Radius.circular(
                          50.r,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            minimumSize: Size(360.w, 55.h),
                          ),
                          onPressed: () {
                            Get.to(() => PatientInformation());
                          },
                          child: Text(
                            "Start Diagnosis",
                            style: TextStyle(fontSize: 16.h),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    40.r,
                  ),
                  topRight: Radius.circular(
                    40.r,
                  ),
                ),
                child: SizedBox(
                  height: 80.h,
                  child: BottomAppBar(
                    color: bottomAppBarColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(icons[0]),
                        Image.asset(icons[1]),
                        Image.asset(icons[2]),
                        Image.asset(icons[3]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
