// ignore_for_file: use_build_context_synchronously


import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_form.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/auth//presentation/pages/forgot_password.dart';
import 'package:trash2cash/features/auth//presentation/pages/register_page.dart';
import 'package:trash2cash/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:trash2cash/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:trash2cash/features/profile/presentation/widgets/profile_loading_dialog.dart';

class LoginWithMail extends StatefulWidget {
  const LoginWithMail({super.key});

  @override
  State<LoginWithMail> createState() => _LoginWithMailState();
}

class _LoginWithMailState extends State<LoginWithMail> {
  final box = GetStorage();
  bool _passwordVisible = false;
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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is Authenticated) {
              // Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => GateKeeper())  
              //          );

              showDialog(
          context: context,
          // barrierDismissible: false, // User cannot dismiss it
          builder: (dialogContext) {
            // It's crucial to provide the ProfileBloc to the dialog's context.
            // context.read<ProfileBloc>() finds the BLoC provided in main.dart
            return BlocProvider.value(
              value: context.read<ProfileBloc>(),
              child: const ProfileLoadingDialog(),
            );
          },
        );
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: RText(title: state.error.toString(), style: TextStyle(color: Colors.black, fontSize: 12.sp,fontWeight: FontWeight.w400 ),),
                        backgroundColor: Colors.red,
                      ),
                    );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is AuthLoading;
            return SafeArea(
          child: SingleChildScrollView(
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
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  10.l,
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
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
                    onTap: isLoading
                            ? null
                            : () {
                                context.read<AuthBloc>().add(
                                      AuthLoginRequested(
                                        emailTextEditingController.text.trim(),
                                        passwordTextEditingController.text
                                            .trim(),
                                      ),
                                    );
                              },
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Tcolor.PrimaryGreen,
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
              title: "Sign in",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
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
        );
          }
        )
      ),
    );
  }
}
