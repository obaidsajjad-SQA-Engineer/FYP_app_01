// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:patient_app/pages/common_widgets/notifications_widget.dart';
import 'package:patient_app/pages/constants.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuScreen(),
      mainScreen: MainScreen(),
      borderRadius: 24,
      showShadow: true,
      menuBackgroundColor: backgroundColor,
      drawerShadowsBackgroundColor: const Color.fromARGB(255, 255, 196, 107),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.person_outline_sharp),
              title: Text("Obaid Sajjad"),
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text("obaid@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.login_outlined),
              title: Text("Logout"),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> names = ['Ali', 'Hamza', 'Umama', 'Umar', 'Usman'];
    final List<String> profilePics = [
      'assets/images/ali.png',
      'assets/images/hamza.png',
      'assets/images/umama.png',
      'assets/images/umar.png',
      'assets/images/usman.png'
    ];
    final List<String> approved_disapproved = [
      'assets/images/approved.png',
      'assets/images/disapproved.png',
      'assets/images/disapproved.png',
      'assets/images/disapproved.png',
      'assets/images/disapproved.png',
    ];
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
                height: 600.h,
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
                      "Bookings",
                      style: TextStyle(
                        fontSize: 30.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 450.h,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: names.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                              right: 25.w,
                            ),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                20.r,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: 20.r,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 4.w,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    20.r,
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 25.r,
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      profilePics[index],
                                    ),
                                  ),
                                  title: Text(names[index]),
                                  subtitle: Text("Neurologist"),
                                  trailing:
                                      Image.asset(approved_disapproved[index]),
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
                height: MediaQuery.of(context).size.height * 0.1,
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
          )
        ],
      ),
    );
  }
}
