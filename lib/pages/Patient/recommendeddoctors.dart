// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/Patient/requestAppointment.dart';
import 'package:patient_app/pages/Patient/results.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

Widget buildOrangeCircularProgressBar(
    {double size = 50.0, double strokeWidth = 4.0}) {
  return SizedBox(
    width: size,
    height: size,
    child: CircularProgressIndicator(
      strokeWidth: strokeWidth,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
    ),
  );
}

class RecommendedDoctors extends StatefulWidget {
  final File uploadedImage;
  final isFetching;
  const RecommendedDoctors(
      {super.key, required this.uploadedImage, required this.isFetching});

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      mainScreen: MainScreen(
        uploadedImage: widget.uploadedImage,
        isFetching: widget.isFetching,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final File uploadedImage;
  final isFetching;
  MainScreen(
      {super.key, required this.uploadedImage, required this.isFetching});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<bool> isDoctorTapped = [false, false, false, false, false];

  String selectedDoctorName = "";
  late List<Map<String, dynamic>> Doctors;
  bool f = isFetching;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> doctors = await getDoctors();
      List<String> doctorUserIds =
          doctors.map((doc) => doc['userId'].toString()).toList();
      List<Map<String, dynamic>> doctorUsers =
          await getDoctorUsers(doctorUserIds);

      // Merge doctor and user data based on userId
      List<Map<String, dynamic>> mergedDoctors = doctors.map((doctor) {
        Map<String, dynamic>? user = doctorUsers.firstWhere(
          (user) => user['userId'] == doctor['userId'],
          orElse: () => {},
        );
        return {...doctor, ...user};
      }).toList();

      setState(() {
        f = false;
        Doctors = mergedDoctors;
        print("Doctors: $Doctors");
      });
    } catch (error) {
      print('Error: $error');
      // Handle error as needed
    }
  }

  Future<List<Map<String, dynamic>>> getDoctors() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('doctors')
              .where('specializations', arrayContains: 'Cardiologist')
              .where('allowUser', isEqualTo: true)
              .get();

      List<Map<String, dynamic>> doctors = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("getDoctors: $doctors");

      return doctors;
    } catch (error) {
      print('Error getting doctors: $error');
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<Map<String, dynamic>>> getDoctorUsers(
      List<String> userIds) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', whereIn: userIds)
              .get();

      List<Map<String, dynamic>> users = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("getDoctorUsers: $users");

      return users;
    } catch (error) {
      print('Error getting doctor users: $error');
      return []; // Return an empty list in case of an error
    }
  }

  // Function to navigate to RequestAppointment screen with selected doctor's details
  void navigateToRequestAppointment(int selectedDoctorIndex) {
    if (selectedDoctorIndex >= 0 && selectedDoctorIndex < Doctors.length) {
      Map<String, dynamic> selectedDoctor = Doctors[selectedDoctorIndex];
      Get.to(() => RequestAppointment(
            doctorName: selectedDoctor['name'],
            doctorExperience: selectedDoctor['experience'],
            doctorSpecialization:
                selectedDoctor['specializations']?.isNotEmpty ?? false
                    ? selectedDoctor['specializations'][0]
                    : '',
            uploadedReport: widget.uploadedImage,
          ));
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 820.h,
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
                      "Doctors",
                      style: TextStyle(
                        fontSize: 34.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 560.h,
                      child: f
                          ? CircularProgressIndicator(
                              strokeWidth: 5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.orange),
                            )
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: Doctors.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> doctor = Doctors[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                  ),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(
                                      20.r,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            for (int i = 0;
                                                i < isDoctorTapped.length;
                                                i++) {
                                              if (i != index) {
                                                isDoctorTapped[i] = false;
                                              }
                                            }
                                            isDoctorTapped[index] = true;
                                            //selected doctor name
                                          },
                                        );
                                        print(
                                            'isDoctorTapped: $isDoctorTapped');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          right: 15.w,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 3.w,
                                          ),
                                          color: isDoctorTapped[index]
                                              ? Colors.grey
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 30.r,
                                            backgroundImage: NetworkImage(
                                                'https://spng.pngfind.com/pngs/s/80-804674_png-file-male-user-vector-transparent-png.png'),
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 116, 16),
                                          ),
                                          title: Text(
                                            doctor['name'] ??
                                                '', // Use the actual field from your data
                                            style: TextStyle(fontSize: 22.h),
                                          ),
                                          subtitle: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                doctor['specializations']
                                                            ?.isNotEmpty ??
                                                        false
                                                    ? doctor['specializations']
                                                            [0] ??
                                                        ''
                                                    : '',
                                                style:
                                                    TextStyle(fontSize: 14.h),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                "Current Job: ${doctor['currentJob']}",
                                                style:
                                                    TextStyle(fontSize: 14.h),
                                              ),
                                            ],
                                          ),
                                          trailing: CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                255, 255, 183, 75),
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  fontSize: 22.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
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
                      height: 20.h,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        minimumSize: Size(360.w, 55.h),
                      ),
                      onPressed: () {
                        // Find the index of the selected doctor
                        int selectedDoctorIndex = isDoctorTapped.indexOf(true);
                        navigateToRequestAppointment(selectedDoctorIndex);
                      },
                      child: Text(
                        "Request Appointment",
                        style: TextStyle(fontSize: 14.h),
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
