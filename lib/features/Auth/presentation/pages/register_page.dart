import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final nameTextEditingController = TextEditingController();
    final emailTextEditingController = TextEditingController();
    final passwordTextEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.l,
            GestureDetector( onTap: () {
              Navigator.pop(context);
            }, child: Icon(Icons.arrow_back),),
            
            20.l,
            RText(
                title: "place holder text",
                style: TextStyle(color: Colors.black, fontSize: 20.sp)),
            10.l,
            RText(
                title: "place holder text",
                style: TextStyle(color: Colors.black, fontSize: 20.sp)),
            40.l,
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RegisterPage()),
                );
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff2E7D32),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: RText(
                      title: "Continue with google",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            30.l,
            Center(
              child: RText(
                title: "Or",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            30.l,

            RText(
                title: "First Name",
                style: TextStyle(color: Colors.black, fontSize: 15.sp)),
            CustomForm(
              darkTheme: false,
              prefixIcon: null,
              hintText: "Enter first name",
              controller: nameTextEditingController,
              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "name can\'t be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid name";
                                }
                                if (text.length > 50) {
                                  return "name can\'t be more than 50 characters";
                                }
                                return null;
                              },
              
              ),
              10.l,

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

              RText(
                title: "Password",
                style: TextStyle(color: Colors.black, fontSize: 15.sp)),
            CustomForm(
              darkTheme: false,
              prefixIcon: null,
              hintText: "Enter password",
              controller: passwordTextEditingController,
              obscureText: !_passwordVisible,
              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
              ),
              20.l,


              GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RegisterPage()),
                );
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff2E7D32),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: RText(
                      title: "Create your Account",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
