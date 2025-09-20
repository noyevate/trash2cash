import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/schedule/presentation/pages/create_schedule.dart';
import 'package:trash2cash/features/waste/domain/entities/recycler_waste_listing.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key, required this.listing});
  final RecyclerWasteListing listing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.PrimaryYellow,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Ionicons.arrow_back_circle_outline),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                            ),
                            child: RText(
                              title: "Payment Successful",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ]),
              ],
            ),
          ),
        ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RText(
                  title: "🎉 “Payment Successful!”",
                  style: TextStyle(color: Colors.black, fontSize: 25.sp, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
              RText(
                  title: "“You’ve successfully paid for this waste. Next,",
                  style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                  RText(
                  title: "schedule your pick-up.”",
                  style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
              
              40.l,
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CreateSchedule(listing: listing,)),
                  );
              
                  // print(passwordTextEditingController.text);
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Tcolor.PrimaryGreen,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                    child: RText(
                      title: "Proceed to Schedule Pick-Up",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

