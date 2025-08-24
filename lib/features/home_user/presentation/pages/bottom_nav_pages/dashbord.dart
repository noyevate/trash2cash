import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/balance_card.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/custom_appbar.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/dashed_line_row.dart';

class Dashbord extends StatelessWidget {
  const Dashbord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(preferredSize: Size.fromHeight(550.h), child: CustomAppbar()),
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        child: Column(
          children: [
            CustomAppbar(),
            20.l,
            BalanceCard(),

            20.l,
            DashedLineRow(
        leftText: "Waste Listing", 
        
      ),

      // Expanded(child: 
      // ListView.builder(itemBuilder: ()))



          ],
        ),
      )
      ),
    );
  }
}