import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';

class WithdrawFundsCustomAppbar extends StatelessWidget {
  const WithdrawFundsCustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Tcolor.PrimaryGreen,

      ),
      child: Column(
        children: [
          30.l,
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Ionicons.arrow_back_circle_outline, color: Colors.white,)),
              RText(title: "Withdraw Funds", style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w600)),
              

            ],
          ),
          RText(title: "Easily transfer your earnings to your preferred\naccount.", style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}