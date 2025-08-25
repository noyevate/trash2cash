import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/balance_card.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/custom_appbar.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/dashed_line_row.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/view_details.dart';

import '../../../../../constants/r_text.dart';

class Dashbord extends StatelessWidget {
  const Dashbord({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(preferredSize: Size.fromHeight(550.h), child: CustomAppbar()),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
        child: Column(
          children: [
            CustomAppbar(
              name: box.read("name") ?? "",
            ),
            20.l,
            BalanceCard(),
            20.l,
            DashedLineRow(
              leftText: "Waste Listing",
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.w,
                    mainAxisSpacing: 30.h,
                    childAspectRatio: 4.5 / 2.5,
                    mainAxisExtent: 250.h,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    String imagePath = (index % 2 == 0)
                        ? "images/waste1.png"
                        : "images/waste2.png";
                    String title =
                        (index % 2 == 0) ? "Bottles and Plastics" : "Glass";

                    String type = (index % 2 == 0) ? "plastic" : "Bottles";

                    String weight = (index % 2 == 0) ? "15kg" : "150kg";
                    return Container(
                      height: 250.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120.h,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r)),
                              child: Image.asset(
                                imagePath,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          15.l,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RText(
                                  title: title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900)),
                              Container(
                                height: 20.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Tcolor.SecondaryGreenr),
                                child: Center(
                                  child: RText(
                                      title: "paid",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w900)),
                                ),
                              )
                            ],
                          ),
                          15.l,
                          Row(
                            children: [
                              RText(
                                  title: type,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900)),
                              5.b,
                              CircleAvatar(
                                radius: 2, // dot size
                                backgroundColor: Colors.grey, // dot color
                              ),
                              5.b,
                              RText(
                                  title: weight,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900))
                            ],
                          ),
                          15.l,
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsPage(
                                    imagePath: imagePath,
                                    title: title,
                                    type: type,
                                    weight: weight,
                                    status: "paid",
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                RText(
                                    title: "View Details",
                                    style: TextStyle(
                                        color: Tcolor.tertiaryGreen,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w900)),
                                5.b,
                                GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.arrow_right_alt_outlined,
                                      color: Tcolor.tertiaryGreen,
                                      size: 20.sp,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
