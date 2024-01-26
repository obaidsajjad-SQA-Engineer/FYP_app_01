// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/Patient/results.dart';
import 'package:patient_app/pages/classes/patient_info.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

class Interview extends StatefulWidget {
  final PatientInfo patientInfo;

  const Interview({
    super.key,
    required this.patientInfo,
  });

  @override
  State<Interview> createState() => _InterviewState();
}

class _InterviewState extends State<Interview> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      mainScreen: MainScreen(
        patientInfo: widget.patientInfo,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final PatientInfo patientInfo;
  MainScreen({
    super.key,
    required this.patientInfo,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> options = [
    'Fatigue',
    'Fever',
    'Feeling sick or queasy',
    'Muscle pain',
    'Chills',
  ];

  List<bool> isCheckedList = List.filled(5, false);

  List<String> checkedSymptomsList = [];

  void updateSelectedSymptomsList() {
    checkedSymptomsList.clear(); // Clear the list before updating
    for (int i = 0; i < options.length; i++) {
      if (isCheckedList[i]) {
        checkedSymptomsList.add(options[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppNotifications(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                images[1],
                height: 300.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 480.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Interview",
                      style: TextStyle(
                          fontSize: 34.w, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: 360.w,
                      height: 250.h,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                            ),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 216, 157),
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    options[index],
                                    style: TextStyle(fontSize: 16.h),
                                  ),
                                  leading: Checkbox(
                                    activeColor: backgroundColor,
                                    value: isCheckedList[index],
                                    onChanged: (value) {
                                      setState(() {
                                        isCheckedList[index] = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        minimumSize: Size(360.w, 55.h),
                      ),
                      onPressed: () {
                        updateSelectedSymptomsList();
                        Get.to(
                          () => Results(
                            patientInfo: PatientInfo(
                              checkupFor: widget.patientInfo.checkupFor,
                              patientGender: widget.patientInfo.patientGender,
                              patientAge: widget.patientInfo.patientAge,
                              isOverweight: widget.patientInfo.isOverweight,
                              isHypertension: widget.patientInfo.isHypertension,
                              isSmoker: widget.patientInfo.isSmoker,
                              isInjury: widget.patientInfo.isInjury,
                              selectedSymptomsList:
                                  widget.patientInfo.selectedSymptomsList,
                              checkedSymptomsList: checkedSymptomsList,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 14.h),
                      ),
                    )
                  ],
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
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r)),
              child: SizedBox(
                height: 80.h,
                child: BottomAppBar(
                  color: bottomAppBarColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(icons[0]),
                      Image.asset(iconsFilled[1]),
                      Image.asset(icons[2]),
                      Image.asset(icons[3]),
                    ],
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
