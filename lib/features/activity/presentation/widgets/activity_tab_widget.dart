import 'package:trash2cash/constants/others.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/r_text.dart';

class ActivityTabWidget extends StatelessWidget {
  const ActivityTabWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
      width: width/5.w,
      height: 35.h,
      child: Center(
        child: RText(title: text, style: TextStyle(fontSize: 15.sp)),
      ),
    );
  }
}