import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:patient_app/pages/Patient/bookings.dart';
import 'package:patient_app/pages/constants.dart';

class AppNotifications extends StatefulWidget implements PreferredSizeWidget {
  const AppNotifications({super.key});

  @override
  State<AppNotifications> createState() => _AppNotificationsState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

List<String> notifications = [
  "Notification 1",
  "Notification 2",
  "Notification 3",
];

class _AppNotificationsState extends State<AppNotifications> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        PopupMenuButton(
          icon: Icon(Icons.notifications_active),
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              for (String notification in notifications)
                PopupMenuItem(
                  child: Text(
                    notification,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              PopupMenuItem(
                height: MediaQuery.of(context).size.height * 0.1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: Size(50.w, 25.h),
                  ),
                  onPressed: () {
                    Get.to(Bookings());
                  },
                  child: Text(
                    'See Bookings',
                    style: TextStyle(fontSize: 12.h),
                  ),
                ),
              ),
            ];
          },
        ),
        IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: Icon(Icons.menu),
        ),
      ],
    );
  }
}
