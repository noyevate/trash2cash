import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/auth//presentation/pages/forgot_password.dart';
import 'package:trash2cash/features/auth//presentation/pages/login_with_mail.dart';
import 'package:trash2cash/features/auth//presentation/pages/register_page.dart';

class SsetNewPass extends StatefulWidget {
  const SsetNewPass({super.key});

  @override
  State<SsetNewPass> createState() => _SsetNewPassState();
}

class _SsetNewPassState extends State<SsetNewPass> {
  // ignore: no_leading_underscores_for_local_identifiers
    bool _passwordVisible = false;
    final TextEditingController passwordTextEditingController =
        TextEditingController();
    final TextEditingController confirmPasswordTextEditingController =
        TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Ionicons.arrow_back_circle_outline),
                ),
                Center(
                  child: RText(
                      title: "Set a\nNew Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold)),
                ),
                10.l,
                Center(
                  child: RText(
                      title: "Create a strong password to secure your ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400)),
                ),
                Center(
                  child: RText(
                      title: "account. Make sure it’s something you’ll\nremember.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400)),
                ),
                20.l,
                RText(
                    title: "New Password",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your new password",
                  controller: passwordTextEditingController,
                  
                ),
                10.l,
                RText(
                    title: "Confirm password",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp)),
                CustomForm(
                  darkTheme: false,
                  prefixIcon: null,
                  hintText: "Enter your new password",
                  controller: confirmPasswordTextEditingController,
                  obscureText: !_passwordVisible,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                10.l,
                
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (BuildContext context) => RegisterPage()),
                    // );
            
                    print(passwordTextEditingController.text);
                  },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Tcolor.PrimaryGreen,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Center(
                      child: RText(
                        title: "Reset password",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                10.l,
                Center(
                  child: RText(
                      title: "Remembered your old password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500)),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginWithMail()));
                    },
                    child: RText(
                        title: "Log in instead.",
                        style: TextStyle(
                            color: Tcolor.PrimaryGreen,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
