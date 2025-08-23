import 'package:flutter/material.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RText(
            title: "Trash",
            style: TextStyle(
                color: Tcolor.PrimaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 30),),
                
                10.b,

                RText(
            title: "to",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30),),
                10.b,

                RText(
            title: "Cash",
            style: TextStyle(
                color: Tcolor.PrimaryYellow,
                fontWeight: FontWeight.bold,
                fontSize: 30),),
                
          ]
      )
          
        ),
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
