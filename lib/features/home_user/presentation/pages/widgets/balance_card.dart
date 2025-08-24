import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Tcolor.PrimaryGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RText(
                    title:"Your Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
          
                   Text(
                     "₦60,000",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),              
                        
            ],

            
          ),

          30.l,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   RText(
                    title: "60 pts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                  ElevatedButton(
                onPressed: () {
                  // Handle withdraw action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Tcolor.PrimaryYellow,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                ),
                child:  RText(
                  title: "Withdraw",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: Tcolor.PrimaryGreen
                  ),
                ),
              ),
                ],
              ),
        ],
      ),
    );
  }
}
