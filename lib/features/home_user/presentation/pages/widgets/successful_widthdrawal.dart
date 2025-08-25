import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/home.dart';

class SuccessfulWidthdrawal extends StatelessWidget {
  const SuccessfulWidthdrawal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RText(
                  title: "Minister of Enjoyment",
                  style: TextStyle(color: Colors.black, fontSize: 25.sp, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
              RText(
                  title: "Withdrawal of 60,000 was successful",
                  style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
              
              40.l,
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()),
                  );
              
                  // print(passwordTextEditingController.text);
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Tcolor.PrimaryGreen,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "Okay, Thank you",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

