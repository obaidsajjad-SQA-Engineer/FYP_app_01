// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient_app/pages/classes/patient_info.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/info_tile.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class PatientReport extends StatefulWidget {
  final PatientInfo patientInfo;
  const PatientReport({super.key, required this.patientInfo});

  @override
  State<PatientReport> createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
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
  final ScreenshotController _screenshotController = ScreenshotController();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = pickedFile;
      });
    } else {
      print("No Permission Granted");
    }
  }

  Future<String> saveImage(Uint8List imageBytes) async {
    await Permission.storage.request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', "-")
        .replaceAll(":", "-");
    final result =
        await ImageGallerySaver.saveImage(imageBytes, name: "Reports$time");

    return result['filepath'];
  }

  Future<File> bytesToFile(Uint8List bytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    final file = File('$tempPath/$fileName');

    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    var patientName = "Obaid Sajjad";
    var patientEmail = "obaid@gmail.com";
    var patientGender = widget.patientInfo.patientGender;
    var patientAge = widget.patientInfo.patientAge.toString();
    var isOverweight = widget.patientInfo.isOverweight;
    var isHypertension = widget.patientInfo.isHypertension;
    var isSmoker = widget.patientInfo.isSmoker;
    var isInjury = widget.patientInfo.isInjury;

    List? searchedSymptoms = widget.patientInfo.selectedSymptomsList;
    List? checkSymptoms = widget.patientInfo.checkedSymptomsList;

    List? symptoms = checkSymptoms! + searchedSymptoms!;

    List desease = ["Block Arteries", "Asthma"];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppNotifications(),
      body: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Column(
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
                        "Patient Report",
                        style: TextStyle(
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Screenshot(
                        controller: _screenshotController,
                        child: Container(
                          color: Colors.white,
                          height: 640.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 30.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/images/applogo.png"),
                                    InkWell(
                                      onTap: () {
                                        if (_imageFile == null) {
                                          // If an image is already selected, allow the user to pick a new one
                                          _pickImage();
                                        }
                                      },
                                      child: _imageFile == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: backgroundColor,
                                              ),
                                              height: 55.0,
                                              width: 60.0,
                                              child: Center(
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 100.h,
                                              width: 100.w,
                                              child: Image.file(
                                                File(_imageFile!.path),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                InfoTile(
                                  title: "Patient name:",
                                  responseWidget: Text(
                                    patientName,
                                  ),
                                ),
                                InfoTile(
                                  title: "Patient Email:",
                                  responseWidget: Text(
                                    patientEmail,
                                  ),
                                ),
                                InfoTile(
                                  title: "Gender:",
                                  responseWidget: Text(
                                    patientGender == 1 ? "Male" : "Female",
                                  ),
                                ),
                                InfoTile(
                                  title: "Age:",
                                  responseWidget: Text(
                                    patientAge,
                                  ),
                                ),
                                InfoTile(
                                  title: "Overweight:",
                                  responseWidget: Text(
                                    isOverweight == 1 ? "Yes" : "No",
                                  ),
                                ),
                                InfoTile(
                                  title: "Hypertension:",
                                  responseWidget: Text(
                                    isHypertension == 1 ? "Yes" : "No",
                                  ),
                                ),
                                InfoTile(
                                  title: "Smoking >10 years:",
                                  responseWidget: Text(
                                    isSmoker == 1 ? "Yes" : "No",
                                  ),
                                ),
                                InfoTile(
                                  title: "Injuries (if any):",
                                  responseWidget: Text(
                                    isInjury == 1 ? "Yes" : "No",
                                  ),
                                ),
                                InfoTile(
                                  title: "Symptoms:",
                                  responseWidget: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: List.generate(symptoms.length,
                                          (index) {
                                        String text = symptoms[index];
                                        return Card(
                                          borderOnForeground: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.r)),
                                          shadowColor: backgroundColor,
                                          elevation: 5,
                                          surfaceTintColor: backgroundColor,
                                          color: backgroundColor,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 5.h),
                                            child: Text(
                                              text,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                InfoTile(
                                  title: "Detected desease:",
                                  responseWidget: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      children: List.generate(desease.length,
                                          (index) {
                                        String text = desease[index];
                                        return Card(
                                          borderOnForeground: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.r)),
                                          shadowColor: backgroundColor,
                                          elevation: 5,
                                          surfaceTintColor: backgroundColor,
                                          color: backgroundColor,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 5.h),
                                            child: Text(
                                              text,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 3.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final image =
                                    await _screenshotController.capture();
                                if (image == null) return;
                                await saveImage(image);
                              },
                              child: Image.asset(
                                "assets/images/download.png",
                                width: 60.h,
                                height: 60.w,
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final image =
                                    await _screenshotController.capture();

                                File myImage =
                                    await bytesToFile(image!, "Obaid.jpg");

                                await Share.shareXFiles([XFile(myImage.path)]);
                              },
                              child: Image.asset(
                                "assets/images/share.png",
                                width: 60.h,
                                height: 60.w,
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
