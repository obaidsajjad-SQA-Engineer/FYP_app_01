// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patient_app/pages/Patient/startdiagnosis.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class RequestAppointment extends StatefulWidget {
  final String doctorName;
  final String doctorExperience;
  final String doctorSpecialization;
  final File uploadedReport;
  const RequestAppointment({
    super.key,
    required this.doctorName,
    required this.doctorExperience,
    required this.doctorSpecialization,
    required this.uploadedReport,
  });

  @override
  State<RequestAppointment> createState() => _RequestAppointmentState();
}

class _RequestAppointmentState extends State<RequestAppointment> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      mainScreen: MainScreen(
        doctorName: widget.doctorName,
        doctorExperience: widget.doctorExperience,
        doctorSpecialization: widget.doctorSpecialization,
        uploadedReport: widget.uploadedReport,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String doctorName;
  final String doctorExperience;
  final String doctorSpecialization;

  final File uploadedReport;
  const MainScreen(
      {super.key,
      required this.doctorName,
      required this.doctorExperience,
      required this.doctorSpecialization,
      required this.uploadedReport});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var appointmentTime = "";
  DateTime? _selectedDate; // Make _selectedDate nullable
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _requestAppointment(BuildContext context) {
    // Create a map with the data to be uploaded to Firebase
    Map<String, dynamic> appointmentData = {
      'selectedDate':
          _selectedDate != null ? _selectedDate!.toIso8601String() : null,
      'selectedTime': appointmentTime,
      //'uploadedReportUrl': widget.uploadedReport,
    };
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 400.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  images[1],
                  width: 150.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Thank You!",
                  style: TextStyle(fontSize: 30.h, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Request Successful",
                  style: TextStyle(
                    fontSize: 16.h,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: Column(
                      children: [
                        Text(
                          "Warning: You can't change it later !!!",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.h),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "You requested an appointment with Dr. ${widget.doctorName} on ${DateFormat('yyyy-MM-dd').format(_selectedDate!)} at $appointmentTime",
                          style: TextStyle(
                              color: Colors.grey[800], fontSize: 12.h),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () async {
                      // Upload data to Firebase Firestore
                      try {
                        await FirebaseFirestore.instance
                            .collection('patients')
                            .add(appointmentData);

                        final storageRef = FirebaseStorage.instance.ref();

                        final mountainsRef =
                            storageRef.child(widget.uploadedReport.path);

                        mountainsRef.putFile(widget.uploadedReport);

                        // Show success dialog or navigate to the next screen
                      } catch (error) {
                        // Handle error
                        print('Error uploading appointment data: $error');
                      }
                      Get.offAll(() => StartDiagnosis());
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 14.h),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Edit your appointment",
                    style: TextStyle(fontSize: 14.h),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int selectedContainerIndex = -1;

  void _onContainerTapped(int index) {
    setState(() {
      if (selectedContainerIndex == index) {
        selectedContainerIndex = -1; // Deselect if already selected
      } else {
        selectedContainerIndex = index; // Select the tapped container
      }
    });
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 820.h,
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
                      "Request Appointment",
                      style: TextStyle(
                          fontSize: 34.w, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 35.w,
                        right: 35.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.doctorName,
                            style: TextStyle(
                                color: Colors.lightBlue.shade900,
                                fontSize: 24.h),
                          ),
                          Container(
                            height: 30.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                "${widget.doctorExperience} years Experience",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.h),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35.w),
                      child: Row(
                        children: [
                          Text(
                            widget.doctorSpecialization,
                            style: TextStyle(fontSize: 16.h),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      color: Color.fromARGB(255, 255, 222, 172),
                      width: MediaQuery.of(context).size.width,
                      height: 300.h,
                      child: TableCalendar(
                        selectedDayPredicate: (day) {
                          return false;
                        },
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          decoration: BoxDecoration(color: buttonColor),
                        ),
                        calendarStyle: CalendarStyle(
                          tablePadding: EdgeInsets.only(
                            left: 35.w,
                            right: 35.w,
                          ),
                        ),
                        rowHeight: 35.h,
                        focusedDay: DateTime.now(),
                        firstDay: DateTime.now(),
                        lastDay: DateTime.utc(2030, 8, 1),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(
                            () {
                              _selectedDate =
                                  selectedDay; // Update the selected date when pressed
                            },
                          );
                        },
                        calendarBuilders: CalendarBuilders(
                          // Customize the day cell appearance
                          defaultBuilder: (context, date, events) {
                            // Check if the date is the selected date
                            final isFocused =
                                date.isAtSameMomentAs(_selectedDate!);

                            // Define your focused and non-focused cell styling
                            final cellDecoration = BoxDecoration(
                              color: isFocused ? buttonColor : Colors.white,
                              shape: BoxShape.circle,
                            );
                            return Container(
                              margin: EdgeInsets.all(4.w),
                              alignment: Alignment.center,
                              decoration: cellDecoration,
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  color:
                                      isFocused ? Colors.white : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 360.w,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(0);
                                    setState(() {
                                      appointmentTime = "09:00 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 0
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "09:00 AM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(1);
                                    setState(() {
                                      appointmentTime = "09:30 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 1
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "09:30 AM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(2);
                                    setState(() {
                                      appointmentTime = "10:00 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 2
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "10:00 AM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(3);
                                    setState(() {
                                      appointmentTime = "10:30 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 3
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "10:30 AM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(4);
                                    setState(() {
                                      appointmentTime = "11:00 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 4
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "11:00 AM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(5);
                                    setState(() {
                                      appointmentTime = "11:30 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 5
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "11:30 AM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(6);
                                    setState(() {
                                      appointmentTime = "12:00 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 6
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "12:00 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(7);
                                    setState(() {
                                      appointmentTime = "12:30 AM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 7
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "12:30 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(8);
                                    setState(() {
                                      appointmentTime = "02:00 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 8
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "02:00 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(9);
                                    setState(() {
                                      appointmentTime = "02:30 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 9
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "02:30 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(10);
                                    setState(() {
                                      appointmentTime = "03:00 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 10
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "03:00 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(11);
                                    setState(() {
                                      appointmentTime = "03:30 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 11
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "03:30 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(12);
                                    setState(() {
                                      appointmentTime = "04:00 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 12
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "04:00 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(13);
                                    setState(() {
                                      appointmentTime = "04:30 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 13
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "04:30 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(14);
                                    setState(() {
                                      appointmentTime = "05:00 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 14
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "05:00 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _onContainerTapped(15);
                                    setState(() {
                                      appointmentTime = "05:30 PM";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: selectedContainerIndex == 15
                                          ? buttonColor
                                          : Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    width: 55.w,
                                    height: 35.h,
                                    child: Center(
                                      child: Text(
                                        "05:30 PM",
                                        style: TextStyle(fontSize: 10.w),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                _requestAppointment(context);
                              },
                              child: Text(
                                "Request Appointment",
                                style: TextStyle(fontSize: 14.h),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                      Image.asset(icons[1]),
                      Image.asset(icons[2]),
                      Image.asset(iconsFilled[3]),
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
