import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextEditingController =
        TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          title: "Reset\nYour Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.sp,
                              fontWeight: FontWeight.bold)),
                  ),
          
              10.l,
                Center(
                  child: RText(
                      title: "we’ll help you get back into your account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400)),
                ),
              
              20.l,
              RText(
                  title: "Email",
                  style: TextStyle(color: Colors.black, fontSize: 15.sp)),
              CustomForm(
                darkTheme: false,
                prefixIcon: null,
                hintText: "Enter your name",
                controller: emailTextEditingController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "email can\'t be empty";
                  }
                  if (text.length < 2) {
                    return "Please enter a valid email";
                  }
                  if (EmailValidator.validate(text) == true) {
                    return null;
                  }
                  if (text.length > 50) {
                    return "email can\'t be more than 50 characters";
                  }
                  return null;
                },
              ),
              10.l,

              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (BuildContext context) => RegisterPage()),
                  // );
          
                  print(emailTextEditingController.text);
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Tcolor.PrimaryGreen,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "Send",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              10.l,

              Center(
                    child: RText(
                          title: "You’ll receive a link to create a new\n password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
                  ),
              
            ],
          ),
        ),
      ),
    );
  }
}
