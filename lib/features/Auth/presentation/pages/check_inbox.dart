import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/Auth/presentation/pages/sset_new_pass.dart';

class CheckInbox extends StatelessWidget {
  const CheckInbox({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Ionicons.arrow_back_circle_outline)),
                ),
                Center(
                      child: RText(
                            title: "Check\nyour Inbox",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.bold)),
                    ),
            
                10.l,
                Center(
                  child: RText(
                      title: "We’ve sent a password reset link\nto ologunemmnauel2015@gmail.com.Click\nthe link to set a new password and get\nback into your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400)),
                ),


                60.l,

                GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (BuildContext context) => CheckInbox(email: emailTextEditingController.text,)),
                  // );
          
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Tcolor.PrimaryGreen,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "Open email",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              10.l,
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SsetNewPass()),
                  );
          
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Tcolor.PrimaryGreen,
                      border: Border.all(color: Tcolor.PrimaryGreen),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "Resend code",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Tcolor.PrimaryGreen,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              10.l,
            ],
          ),
        ),
      ),
    );
  }
}