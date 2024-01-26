// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/Patient/addSymptoms.dart';
import 'package:patient_app/pages/Patient/bmiCalculator.dart';
import 'package:patient_app/pages/classes/patient_info.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

class PatientInformation extends StatefulWidget {
  const PatientInformation({super.key});

  @override
  State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      mainScreen: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double slideAmount = 0.0;
  double screenHeight = 0.0;
  double _sliderValue = 30;
  int q1Container = 0;
  int q2Container = 0;
  int q4aContainer = 0;
  int q4bContainer = 0;
  int q4cContainer = 0;
  int q4dContainer = 0;

  //Information to send on next page
  var checkupFor = 0;
  var patientGender = 0;
  var patientAge = 30;
  var isOverweight = 0;
  var isHypertension = 0;
  var isSmoker = 0;
  var isInjury = 0;

  bool q1_check = false;
  bool q2_check = false;
  bool q4a_check = false;
  bool q4b_check = false;
  bool q4c_check = false;
  bool q4d_check = false;

  void _q1(int containerIndex) {
    setState(
      () {
        q1Container = containerIndex;
        q1_check = true;

        if (containerIndex == 1) {
          //checkup for myself
          checkupFor = 1;
        } else if (containerIndex == 2) {
          //checkup for someone else
          checkupFor = 2;
        }
      },
    );
  }

  void _q2(int containerIndex) {
    setState(
      () {
        q2Container = containerIndex;
        q2_check = true;

        if (containerIndex == 1) {
          //Male
          patientGender = 1;
        } else if (containerIndex == 2) {
          //Female
          patientGender = 2;
        }
      },
    );
  }

  void _q4parta(int containerIndex) {
    setState(
      () {
        q4aContainer = containerIndex;
        q4a_check = true;

        //containerInder 1 for yes, 2 for no and 3 for dont know
        if (containerIndex == 1) {
          isOverweight = 1;
        } else if (containerIndex == 2) {
          isOverweight = 2;
        }
      },
    );
  }

  void _q4partb(int containerIndex) {
    setState(
      () {
        q4bContainer = containerIndex;
        q4b_check = true;
        //containerInder 1 for yes, 2 for no and 3 for dont know
        if (containerIndex == 1) {
          isHypertension = 1;
        } else if (containerIndex == 2) {
          isHypertension = 2;
        } else if (containerIndex == 3) {
          isHypertension = 3;
        }
      },
    );
  }

  void _q4partc(int containerIndex) {
    setState(
      () {
        q4cContainer = containerIndex;
        q4c_check = true;

        //containerInder 1 for yes, 2 for no and 3 for dont know
        if (containerIndex == 1) {
          isSmoker = 1;
        } else if (containerIndex == 2) {
          isSmoker = 2;
        } else if (containerIndex == 3) {
          isSmoker = 3;
        }
      },
    );
  }

  void _q4partd(int containerIndex) {
    setState(() {
      q4dContainer = containerIndex;
      q4d_check = true;
      //containerInder 1 for yes, 2 for no and 3 for dont know
      if (containerIndex == 1) {
        isInjury = 1;
      } else if (containerIndex == 2) {
        isInjury = 2;
      } else if (containerIndex == 3) {
        isInjury = 3;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppNotifications(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  images[0],
                  height: 300.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
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
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Patient Information",
                        style: TextStyle(
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "1. Who is the checkup for?",
                              style: TextStyle(
                                fontSize: 16.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _q1(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                        color: q1Container == 1
                                            ? containerColor
                                            : Colors.white,
                                      ),
                                      width: 120.w,
                                      height: 120.h,
                                      child: Image.asset(
                                        "assets/images/myself.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Myself",
                                    style: TextStyle(
                                      fontSize: 16.h,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _q1(2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: q1Container == 2
                                            ? containerColor
                                            : Colors.white,
                                      ),
                                      width: 120.w,
                                      height: 120.h,
                                      child: Image.asset(
                                        "assets/images/someone.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Someone Else",
                                    style: TextStyle(
                                      fontSize: 16.h,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "2. Your (His/Her) Gender",
                              style: TextStyle(
                                fontSize: 16.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _q2(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: q2Container == 1
                                            ? containerColor
                                            : Colors.white,
                                      ),
                                      width: 120.w,
                                      height: 120.h,
                                      child: Image.asset(
                                        "assets/images/male.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      fontSize: 16.h,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _q2(2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: q2Container == 2
                                            ? containerColor
                                            : Colors.white,
                                      ),
                                      width: 120.w,
                                      height: 120.h,
                                      child: Image.asset(
                                          "assets/images/female.png"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize: 16.h,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "3. How old are you?    ${_sliderValue.toInt()}",
                              style: TextStyle(
                                fontSize: 16.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          //add slider
                          Center(
                            child: Container(
                              width: 320.w,
                              child: Slider(
                                activeColor: buttonColor,
                                thumbColor: buttonColor,
                                inactiveColor: Colors.grey,
                                value: _sliderValue,
                                min: 0,
                                max: 120,
                                divisions: 120,
                                onChanged: (newValue) {
                                  setState(() {
                                    _sliderValue = newValue;
                                    patientAge = _sliderValue.toInt();
                                  });
                                },
                                label: "${_sliderValue.toInt()}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "4. Check all the statements.",
                              style: TextStyle(
                                fontSize: 16.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 25.w,
                                ),
                                child: Text(
                                  "* I’m overweight or obese.",
                                  style: TextStyle(
                                    fontSize: 16.h,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(buttonColor)),
                                onPressed: () {
                                  Get.to(() => BMICalculator());
                                },
                                child: Text("Check BMI"),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 52.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _q4parta(1);
                                  },
                                  child: Material(
                                    elevation: 2,
                                    child: Container(
                                      color: Colors.pink,
                                      width: 75.w,
                                      height: 45.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontSize: 14.h,
                                            ),
                                          ),
                                          q4aContainer == 1
                                              ? Image.asset(
                                                  "assets/images/checked.png")
                                              : Image.asset(
                                                  "assets/images/unchecked.png"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _q4parta(2);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 51.1.w),
                                    child: Material(
                                      elevation: 2,
                                      child: Container(
                                        color:
                                            Color.fromARGB(255, 84, 200, 186),
                                        width: 75.w,
                                        height: 45.h,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "No",
                                              style: TextStyle(
                                                fontSize: 14.h,
                                              ),
                                            ),
                                            q4aContainer == 2
                                                ? Image.asset(
                                                    "assets/images/checked.png")
                                                : Image.asset(
                                                    "assets/images/unchecked.png"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "* I have hypertension.",
                              style: TextStyle(fontSize: 16.h),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _q4partb(1);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Colors.pink,
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Yes",
                                          style: TextStyle(
                                            fontSize: 14.h,
                                          ),
                                        ),
                                        q4bContainer == 1
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _q4partb(2);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Color.fromARGB(255, 84, 200, 186),
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "No",
                                          style: TextStyle(
                                            fontSize: 14.h,
                                          ),
                                        ),
                                        q4bContainer == 2
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _q4partb(3);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Colors.blue[300],
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Don't",
                                              style: TextStyle(fontSize: 14.h),
                                            ),
                                            Text(
                                              "know",
                                              style: TextStyle(
                                                fontSize: 14.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        q4bContainer == 3
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "* I have smoked cigarettes for at least 10 years.",
                              style: TextStyle(
                                fontSize: 16.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _q4partc(1);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Colors.pink,
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Yes",
                                          style: TextStyle(
                                            fontSize: 14.h,
                                          ),
                                        ),
                                        q4cContainer == 1
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _q4partc(2);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Color.fromARGB(255, 84, 200, 186),
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "No",
                                          style: TextStyle(
                                            fontSize: 14.h,
                                          ),
                                        ),
                                        q4cContainer == 2
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _q4partc(3);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Colors.blue[300],
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Don't",
                                              style: TextStyle(
                                                fontSize: 14.h,
                                              ),
                                            ),
                                            Text(
                                              "know",
                                              style: TextStyle(
                                                fontSize: 14.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        q4cContainer == 3
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                            ),
                            child: Text(
                              "* I’ve recently suffered an injury.",
                              style: TextStyle(
                                fontSize: 16.h,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _q4partd(1);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Colors.pink,
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Yes",
                                          style: TextStyle(
                                            fontSize: 14.h,
                                          ),
                                        ),
                                        q4dContainer == 1
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _q4partd(2);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Color.fromARGB(255, 84, 200, 186),
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "No",
                                          style: TextStyle(
                                            fontSize: 14.h,
                                          ),
                                        ),
                                        q4dContainer == 2
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _q4partd(3);
                                },
                                child: Material(
                                  elevation: 2,
                                  child: Container(
                                    color: Colors.blue[300],
                                    width: 75.w,
                                    height: 45.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Don't",
                                              style: TextStyle(
                                                fontSize: 14.h,
                                              ),
                                            ),
                                            Text(
                                              "know",
                                              style: TextStyle(
                                                fontSize: 14.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        q4dContainer == 3
                                            ? Image.asset(
                                                "assets/images/checked.png")
                                            : Image.asset(
                                                "assets/images/unchecked.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          minimumSize: Size(360.w, 55.h),
                        ),
                        onPressed: () {
                          if (q1_check &&
                              q2_check &&
                              q4a_check &&
                              q4b_check &&
                              q4c_check &&
                              q4d_check) {
                            Get.to(
                              () => AddSymptoms(
                                patientInfo: PatientInfo(
                                  checkupFor: checkupFor,
                                  patientGender: patientGender,
                                  patientAge: patientAge,
                                  isOverweight: isOverweight,
                                  isHypertension: isHypertension,
                                  isSmoker: isSmoker,
                                  isInjury: isInjury,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                  )),
              child: SizedBox(
                height: 80.h,
                child: BottomAppBar(
                  color: bottomAppBarColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(iconsFilled[0]),
                      Image.asset(icons[1]),
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
