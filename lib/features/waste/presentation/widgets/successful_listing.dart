import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/home.dart';

class SuccessfulListing extends StatelessWidget {
  const SuccessfulListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.PrimaryGreen,
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RText(
                  title: "Minister of\nWaste Management",
                  style: TextStyle(color: Colors.white, fontSize: 25.sp, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
              RText(
                  title: "Your listing is now life",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500)),
              
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
                      color: Tcolor.PrimaryYellow,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "View  in dashboard",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
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

