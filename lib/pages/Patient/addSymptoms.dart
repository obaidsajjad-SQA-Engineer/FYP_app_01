// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/Patient/interview.dart';
import 'package:patient_app/pages/classes/patient_info.dart';
import 'package:patient_app/pages/common_widgets/drawer_widget.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

class AddSymptoms extends StatefulWidget {
  final PatientInfo patientInfo;

  const AddSymptoms({
    super.key,
    required this.patientInfo,
  });

  @override
  State<AddSymptoms> createState() => _AddSymptomsState();
}

class _AddSymptomsState extends State<AddSymptoms> {
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
  const MainScreen({
    super.key,
    required this.patientInfo,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> symptomList = [
    'Fever',
    'Cough',
    'Headache',
    'Fatigue',
    'Heart Pain'
        'Shortness of breath',
    'Nausea',
    'Joint pain',
    'Abdominal pain',
    'Chest pain',
    'Dizziness',
  ];

  //Information to send on next page
  List<String> selectedSymptomsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppNotifications(),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
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
                    height: 500.h,
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
                          "Add Symptoms",
                          style: TextStyle(
                            fontSize: 34.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: 380.w,
                          height: 150.h,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 3,
                              crossAxisCount:
                                  3, // Number of columns in the grid
                              crossAxisSpacing: 2, // Spacing between columns
                              mainAxisSpacing: 2, // Spacing between rows
                            ),
                            itemCount: selectedSymptomsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(left: 5.w),
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: backgroundColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedSymptomsList[index].toString(),
                                        style: TextStyle(fontSize: 14.h),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 20.h,
                                      ),
                                      onPressed: () {
                                        // Remove the item from the list when the cross is tapped
                                        setState(() {
                                          selectedSymptomsList.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        TypeAheadField(
                          builder: (context, controller, focusNode) {
                            return SizedBox(
                              width: 360.w,
                              height: 55.h,
                              child: TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.w),
                                  suffixIcon:
                                      Icon(Icons.search, color: buttonColor),
                                  prefixStyle: TextStyle(
                                      color: buttonColor, fontSize: 16.h),
                                  hintText: "Headache, Hairfall",
                                  hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14.h,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2.w,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                    borderSide: BorderSide(
                                      color: buttonColor,
                                      width: 2.w,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemBuilder: (context, String suggestion) {
                            return Column(
                              children: [ListTile(title: Text(suggestion))],
                            );
                          },
                          onSelected: (String suggestion) {
                            setState(() {
                              selectedSymptomsList.add(suggestion);
                            });
                          },
                          suggestionsCallback: (String search) {
                            // Filter the suggestions based on the user's input
                            return symptomList
                                .where((symptom) => symptom
                                    .toLowerCase()
                                    .contains(search.toLowerCase()))
                                .toList();
                          },
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            minimumSize: Size(360.w, 55.h),
                          ),
                          onPressed: () {
                            if (selectedSymptomsList.isEmpty == false) {
                              Get.to(
                                () => Interview(
                                  patientInfo: PatientInfo(
                                    checkupFor: widget.patientInfo.checkupFor,
                                    patientGender:
                                        widget.patientInfo.patientGender,
                                    patientAge: widget.patientInfo.patientAge,
                                    isOverweight:
                                        widget.patientInfo.isOverweight,
                                    isHypertension:
                                        widget.patientInfo.isHypertension,
                                    isSmoker: widget.patientInfo.isSmoker,
                                    isInjury: widget.patientInfo.isInjury,
                                    selectedSymptomsList: selectedSymptomsList,
                                  ),
                                ),
                              );
                            }
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
            ),
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
                  color: Colors.orange[50],
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
