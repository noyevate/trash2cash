import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/Auth/presentation/pages/forgot_password.dart';
import 'package:trash2cash/features/Auth/presentation/pages/register_page.dart';
import 'package:trash2cash/features/home_user/presentation/pages/bottom_nav_pages/dashbord.dart';
import 'package:http/http.dart' as http;

class LoginWithMail extends StatefulWidget {
  const LoginWithMail({super.key});

  @override
  State<LoginWithMail> createState() => _LoginWithMailState();
}

class _LoginWithMailState extends State<LoginWithMail> {
  // ignore: prefer_final_fields
    bool _passwordVisible = false;
    final TextEditingController emailTextEditingController =
        TextEditingController();
    final TextEditingController passwordTextEditingController =
        TextEditingController();


        Future<void> login(BuildContext context) async {
  String email = emailTextEditingController.text.trim();
  String password = passwordTextEditingController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Email and password are required")),
    );
    return;
  }

  try {
    var url = Uri.parse("https://yourapi.com/login"); // replace with your API endpoint
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // assume your API returns something like {"token": "...", "user": {...}}
      String token = data["token"];

      // save token locally
      

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful ✅")),
      );

      // Navigate to home/dashboard
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashbord()));
    } else {
      var errorMsg = jsonDecode(response.body)['message'] ?? "Login failed";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: SafeArea(
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
                  child: Column(
                    children: [
                      RText(
                          title: "Good to",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.sp,
                              fontWeight: FontWeight.bold)),
                      RText(
                          title: "see you again",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.sp,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                10.l,
                Center(
                  child: RText(
                      title: "Log in to keep turning waste into value.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
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
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                10.l,
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()));
                  },
                  child: RText(
                      title: "Forget your Password?",
                      style: TextStyle(
                          color: Tcolor.SecondaryGreen,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500)),
                ),
                15.l,
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
                        title: "Sign in",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                10.l,
                Center(
                  child: RText(
                      title: "Are you yet to register?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500)),
                ),
                10.l,
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: RText(
                        title: "Create your account in 2 mins",
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
