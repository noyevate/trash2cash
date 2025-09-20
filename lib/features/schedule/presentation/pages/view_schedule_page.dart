import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';

class ViewSchedulePage extends StatelessWidget {
  const ViewSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SizedBox(
          child: SafeArea(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Ionicons.arrow_back_circle_outline),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                          ),
                          CircleAvatar(
                            // padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                            radius: 20.h,
                            child: Image.asset("images/home_image.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 15.w,
                            ),
                            child: RText(
                              title: "View Schedule",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [],
      ),
    );
  }
}