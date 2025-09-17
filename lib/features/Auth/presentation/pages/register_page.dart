import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:trash2cash/features/Auth/presentation/pages/login_page.dart';
import 'package:trash2cash/features/auth/presentation/pages/login_with_mail.dart';
import 'package:trash2cash/features/choose_role/presentation/pages/choose_role.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;

  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
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
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RText(
                        title: "Or",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              20.sp, // or 20.sp if you're using ScreenUtil
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
                30.l,
                BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                  // --- HANDLE SIDE EFFECTS HERE ---
                  if (state is RegistrationSuccess) {
                    // On success, navigate to the home screen or profile setup
                    // and remove the auth screens from the back stack.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: RText(
                            title:'Account Successfully Created', style: TextStyle(color: Colors.black, fontSize: 20.sp,fontWeight: FontWeight.w400 ),),
                        backgroundColor: Colors.white,
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ChooseRole())  
                       );
                    
                    
                    
                  }
                  if (state is AuthFailure) {
                    // On failure, show an error message in a SnackBar
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }, builder: (context, state) {
                  final bool isLoading = state is AuthLoading;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RText(
                          title: "First Name",
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp)),
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
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp)),
                      CustomForm(
                        darkTheme: false,
                        prefixIcon: null,
                        hintText: "Enter your email",
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
                          style:
                              TextStyle(color: Colors.black, fontSize: 15.sp)),
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
                        onTap: isLoading
                            ? null
                            : () {
                                context.read<AuthBloc>().add(
                                      AuthRegisterRequested(
                                        emailTextEditingController.text.trim(),
                                        nameTextEditingController.text.trim(),
                                        passwordTextEditingController.text
                                            .trim(),
                                      ),
                                    );
                              },
                        child: Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xff2E7D32),
                              borderRadius: BorderRadius.circular(30.r)),
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : RText(
                                    title: "Create your Account",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
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
                            style: TextStyle(
                                color: Tcolor.PrimaryGreen, fontSize: 15.sp)),
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
