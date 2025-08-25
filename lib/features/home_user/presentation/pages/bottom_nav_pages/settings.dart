import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: RText(
                                    title: "In develoment..",
                                    style: TextStyle(
                                        color: Tcolor.BorderColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900)),
        ),
      ),
    );
  }
}