import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';

class CreateListAppbar extends StatelessWidget {
  const CreateListAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Tcolor.PrimaryYellow,

      ),
      child: Column(
        children: [
          20.l,
          Row(
            children: [
              IconButton(onPressed: () {
                
              }, icon: Icon(Ionicons.arrow_back_circle_outline)),
              RText(title: "Create Your Waste List", style: TextStyle(color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w600)),
              

            ],
          ),
          RText(title: "Add details of the waste items you want to recycle", style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}