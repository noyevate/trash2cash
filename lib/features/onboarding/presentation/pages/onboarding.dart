import 'package:flutter/material.dart';
import 'package:trash2cash/features/onboarding/presentation/pages/auth_selection.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    redirect();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("images/onboaeding_img.png")
      )
    );
  }

  redirect() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => AuthSelection()),
    );
    });
    
  }
}
