import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
      
        ),
        child: Column(
          children: [
            Stack(
              // The alignment property centers the children that aren't explicitly positioned.
              alignment: Alignment.center,
              children: [
                // The title will be perfectly centered by the Stack.
                RText(
                  title: "Account Setup",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600),
                ),

                // Use Align to position the back button to the left.
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Ionicons.arrow_back_circle_outline),
                  ),
                ),
          ],
        ),
          ])
      ),
    );
  }
}