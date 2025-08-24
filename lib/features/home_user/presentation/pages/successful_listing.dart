import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';

class SuccessfulListing extends StatelessWidget {
  const SuccessfulListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.PrimaryGreen,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w,right: 15.w, top: 15.h),
          child: Center(
            child: Column(
              children: [
                RText(
                    title: "Minister of Waste Management",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}