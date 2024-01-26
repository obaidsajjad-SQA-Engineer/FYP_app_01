import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:patient_app/pages/accountmanagement/login.dart';
import 'package:patient_app/pages/auth%20and%20management/authentication.dart';
import 'package:patient_app/pages/constants.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  final name = "Obaid";
  final email = "obaidsajjad913@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline_sharp),
              title: Text(
                name,
                style: TextStyle(fontSize: 12.h),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: Text(
                email,
                style: TextStyle(fontSize: 12.h),
              ),
            ),
            GestureDetector(
              onTap: () {
                AuthenticationHelper.signOut();
                Get.offAll(() => const Login());
              },
              child: ListTile(
                leading: const Icon(Icons.login_outlined),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 12.h),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                "About",
                style: TextStyle(fontSize: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
