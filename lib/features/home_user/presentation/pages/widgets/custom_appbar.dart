import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("images/home_image.png"),
              5.b,
              RText(
                            title: "Welcome, ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500)),
                                RText(
                            title: "Emmanuel",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600)),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Ionicons.notifications_outline, size: 18.sp,))
        ],
      ),
    );
  }
}