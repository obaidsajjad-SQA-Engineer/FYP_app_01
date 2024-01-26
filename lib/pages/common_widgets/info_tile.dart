import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final Widget responseWidget;
  const InfoTile({Key? key, required this.title, required this.responseWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 10,
            child: responseWidget,
          ),
        ],
      ),
    );
  }
}
