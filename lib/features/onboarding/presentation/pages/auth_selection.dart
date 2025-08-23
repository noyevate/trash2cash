import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/Auth/presentation/pages/login_page.dart';
import 'package:trash2cash/features/Auth/presentation/pages/register_page.dart';

class AuthSelection extends StatelessWidget {
  const AuthSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.l,
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: RText(
                  title: "Turn Your",
                  style: TextStyle(color: Colors.black, fontSize: 35.sp, fontWeight: FontWeight.bold)),
            ),
          // 5.l,
            RText(
                title: "Trash Into Cash",
                style: TextStyle(color: Colors.black, fontSize: 35.sp, fontWeight: FontWeight.bold)),
            10.l,
            RText(
                title: "Don’t just throw it away. Connect with",
                style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w400)),
            
            RText(
                title: "recyclers, earn rewards, and help build a",
                style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w400)),

                RText(
                title: "cleaner, greener future.",
                style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w400)),


            25.l,
            Image.asset("images/onboarding_1.png"),
            40.l,
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RegisterPage()),
                  );
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Tcolor.PrimaryGreen,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "Get Started",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            20.l,

            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Color(0xff2E7D32),
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: Tcolor.PrimaryGreen)
                    ),
                  child: Center(
                    child: RText(
                      title: "login",
                      style: TextStyle(fontSize: 20.sp, color: Tcolor.PrimaryGreen),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
