// ignore_for_file: prefer_const_constructors, unused_element, sized_box_for_whitespace, sort_child_properties_last, use_build_context_synchronously, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_app/pages/Patient/patientReport.dart';
import 'package:patient_app/pages/Patient/recommendeddoctors.dart';
import 'package:patient_app/pages/classes/patient_info.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

bool isFetching = true;

class Results extends StatefulWidget {
  final PatientInfo patientInfo;
  const Results({super.key, required this.patientInfo});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
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
  const MainScreen({super.key, required this.patientInfo});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late File _image;
  bool isImageSelected = false;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isImageSelected = true; // Set the boolean variable to true
      } else {
        print('No image selected.');
        isImageSelected =
            false; // Set the boolean variable to false if no image is selected
      }
    });
  }

  void _uploadReportAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 250.h,
            width: 180.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      minimumSize: Size(80.w, 35.h)),
                  onPressed: () async {
                    await getImage();
                    Navigator.of(context).pop();
                    if (isImageSelected) {
                      _successMessageAlertDialog(context);
                    } else {
                      _uploadFailedAlertDialog(context);
                    }
                  },
                  child: Text(
                    "Upload Report",
                    style: TextStyle(fontSize: 14.h),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "Cancel",
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

  void _successMessageAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 300.h,
            width: 180.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 50.r,
                  child: Icon(
                    Icons.thumb_up_off_alt_rounded,
                    size: 50.r,
                    color: Colors.white,
                  ),
                  backgroundColor: backgroundColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Uploaded",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.h,
                  ),
                ),
                Text(
                  "Successfully",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.h,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: Size(80.w, 35.h),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendedDoctors(
                          uploadedImage: _image,
                          isFetching: true,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 14.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _uploadFailedAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 250.h,
            width: 180.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Upload Failed",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.h,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Report upload failed. Retry?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.h,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: Size(80.w, 35.h),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the failed dialog
                    _uploadReportAlertDialog(context); // Retry uploading
                  },
                  child: Text(
                    "Retry",
                    style: TextStyle(
                      fontSize: 14.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              Image.asset(
                images[2],
                height: 250.h,
              ),
              SizedBox(
                height: 50.h,
              ),
              Container(
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
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Results",
                      style: TextStyle(
                        fontSize: 34.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => PatientReport(
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
                              checkedSymptomsList:
                                  widget.patientInfo.checkedSymptomsList,
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/images/downloadreportbutton.png",
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () => _uploadReportAlertDialog(context),
                      child: Image.asset(
                        "assets/images/consultdoctorbutton.png",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(icons[0]),
                      Image.asset(icons[1]),
                      Image.asset(iconsFilled[2]),
                      Image.asset(icons[3]),
                    ],
                  ),
                  color: Colors.orange[50],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
