import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/auth/presentation/pages/login_page.dart';
import 'package:trash2cash/features/auth/presentation/pages/register_page.dart';
import 'dart:async';

class AuthSelection extends StatefulWidget {
  const AuthSelection({super.key});

  @override
  State<AuthSelection> createState() => _AuthSelectionState();
}

class _AuthSelectionState extends State<AuthSelection> {
  int _currentPage = 0;
  // The timer for automatic sliding
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is first created
    _startTimer();
  }

  @override
  void dispose() {
    // IMPORTANT: Cancel the timer and dispose the controller to avoid memory leaks
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Create a periodic timer that fires every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        if (_currentPage < 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
      });
    });
  }

  Widget _buildPageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 10.h,
      width: isActive ? 10.w : 10.w, // Active indicator is wider
      decoration: BoxDecoration(
        color: isActive ? Tcolor.PrimaryGreen : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingPages = [
      _buildOnboardingPage(
        pageIndicators: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPageIndicator(_currentPage == 0),
            _buildPageIndicator(_currentPage == 1),
          ],
        ),
        title1: "Turn Your",
        title2: "Trash Into Cash",
        description:
            "Don’t just throw it away. Connect with recyclers, earn rewards, and help build a cleaner, greener future.",
        // imagePath: "images/onboarding_1.png", // Pass the correct image
      ),
      _buildOnboardingPage(
        pageIndicators: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildPageIndicator(_currentPage == 0),
            _buildPageIndicator(_currentPage == 1),
          ],
        ),
        title1: "Give Waste",
        title2: "A New Life",
        description:
            "Every item you recycle contributes to a healthier planet. Track your impact and see the difference you make.",
        // imagePath: "images/onboarding_2.png", // Pass the second image
      ),
    ];
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.l,
              Expanded(
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(
                          milliseconds: 200), // How long the fade takes
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        // This defines the fade animation
                        return FadeTransition(opacity: animation, child: child);
                      },
                      // The child is the current page from our list.
                      // The key is VERY important. It tells the AnimatedSwitcher that the child has actually changed.
                      child: Container(
                        key: ValueKey<int>(_currentPage),
                        child: onboardingPages[_currentPage],
                      ),
                    ),
                    Image.asset("images/onboarding_1.png"),
                  ],
                ),
              ),
              
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
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
                    Navigator.push(
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
                        border: Border.all(color: Tcolor.PrimaryGreen)),
                    child: Center(
                      child: RText(
                        title: "login",
                        style: TextStyle(
                            fontSize: 20.sp, color: Tcolor.PrimaryGreen),
                      ),
                    ),
                  ),
                ),
              ),
              10.l,
            ],
          ),
        ));
  }
}

Widget _buildOnboardingPage({
  required String title1,
  required String title2,
  required String description,
  // required String imagePath,
  required Widget pageIndicators,
}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
               title1,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Metropolis",
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold)),
        ),
        Text(
             title2,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Metropolis",
                fontSize: 35.sp,
                fontWeight: FontWeight.bold)),
        10.l,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
              textAlign: TextAlign.center,
               description,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Metropolis",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400)),
        ),
        20.l,
        pageIndicators,
      ],
    ),
  );
}
