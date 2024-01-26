// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:patient_app/pages/constants.dart';

import 'menu_widget.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, this.mainScreen});
  final mainScreen;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuScreen(),
      mainScreen: widget.mainScreen,
      borderRadius: 24.r,
      showShadow: true,
      menuBackgroundColor: backgroundColor,
      drawerShadowsBackgroundColor: Color.fromARGB(255, 222, 103, 0),
    );
  }
}
