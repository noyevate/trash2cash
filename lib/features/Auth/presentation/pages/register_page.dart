import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/Auth/presentation/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:trash2cash/features/home_user/presentation/pages/bottom_nav_pages/dashbord.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  // ignore: prefer_final_fields
  bool _passwordVisible = false;
  final TextEditingController nameTextEditingController = TextEditingController();
    final TextEditingController emailTextEditingController = TextEditingController();
    final TextEditingController passwordTextEditingController = TextEditingController();



    void _register(BuildContext context) async {
  String name = nameTextEditingController.text.trim();
  String email = emailTextEditingController.text.trim();
  String password = passwordTextEditingController.text.trim();
  print(name);
  print(email);
  print(password);

  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All fields are required")),
    );
    return;
  }

  try {
    var url = Uri.parse("https://$appBaseUrl/auth/register"); 
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": name,
        "email": email,
        "password": password,
      }),
    );
    print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful ✅")),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashbord()));
    } else {
      var errorMsg = jsonDecode(response.body)['message'] ?? "Registration failed";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  } catch (e) {
    print(e);
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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.l,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Ionicons.arrow_back_circle_outline),
                    ),
                    20.b,
                    Column(
                      children: [
                        RText(
                            title: "Join the Green",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.bold)),
                        RText(
                            title: "Movement",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                20.l,
                RText(
                    title: "Create an account to start earning from",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400)),
                RText(
                    title: "your waste and support a cleaner ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400)),
                RText(
                    title: "environment.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400)),
                25.l,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RegisterPage()),
                    );
                  },
                  child: Container(
                    height: 70.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Tcolor.PrimaryGreen),
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "images/Google@2x.png",
                            height: 20.h,
                            width: 20.w,
                          ),
                          15.b,
                          RText(
                            title: "Continue with google",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                30.l,
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp, // or 20.sp if you're using ScreenUtil
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                30.l,
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                20.l,
                GestureDetector(
                  onTap: () {
                   _register(context);
                
                    print(passwordTextEditingController.text);
                  },
                  child: Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff2E7D32),
                        borderRadius: BorderRadius.circular(30.r)),
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
                
                
                
                
                ],
               ),
                
               10.l,
                RText(
                    title: "We keep your details safe. No spam, no sharing.",
                    style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RText(
                          title: "Already have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                    );
                            },
                            child: RText(
                            title: "Log in",
                            style: TextStyle(color: Tcolor.PrimaryGreen, fontSize: 15.sp)),
                          ),
                    ],
                  ),
                ),
                
                
                10.l,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
