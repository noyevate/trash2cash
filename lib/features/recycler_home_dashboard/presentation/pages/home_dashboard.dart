import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/custom_search.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/view_details.dart';
import 'package:trash2cash/features/recycler_home_dashboard/presentation/widgets/custom_appbar.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190.h),
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
          child: Column(
            children: [
              20.l,
              CustomAppbar(
                name: box.read("firstName") ?? "",
              ),
              15.l,
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Tcolor.tertiaryGreen,
                    size: 20.sp,
                  ),
                  5.b,
                  RText(
                    title: 'Ikeja Lagos',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              10.l,
              Row(
                children: [
                  Expanded(
                    child: CustomSearch(
                      hintText: "search for waste or location",
                      suffixIcon: Icon(Ionicons.search),
                    ),
                  ),
                  10.b,
                  InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      onTap: () {},
                      child: Image.asset("images/search_edits.png"))
                ],
              )
            ],
          ),
        ),
      ),
      body: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RText(
          title: 'Nearby Waste Listings',
          style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500),
        ),
        RText(
          title: 'See waste products within 5 km of Ikeja.',
          style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400),
        ),
        20.l,
      
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
                return WastListingTile(imagePath: imagePath, price: 25000, title: title, type: type, weight: weight, unit: "100");
              }),
        )
      ],
              ),
            ),
    );
  }
}



class WastListingTile extends StatelessWidget {
  const WastListingTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.type,
    required this.weight,
    required this.unit,
    required this.price,
  });

  final String imagePath;
  final String title;
  final String type;
  final String weight;
  final String unit;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w), // Simplified padding
      decoration: BoxDecoration(
        color: Tcolor.RecyclerGreyCard,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align everything to the start
        children: [
          // --- IMAGE (No changes needed here) ---
          SizedBox(
            height: 120.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r), // Consistent rounding
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(), // Use Spacer for flexible spacing

          // --- MIDDLE SECTION (TITLE & PRICE) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
            children: [
              // --- 1. EXPANDED LEFT COLUMN (TITLE, TYPE, ETC.) ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // Prevent long titles from wrapping and overflowing
                      overflow: TextOverflow.ellipsis, // Show '...' if too long
                    ),
                    Text(
                      type,
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          "${unit}unit (${weight}kg)",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // --- 2. RIGHT COLUMN (STATUS & PRICE) ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Tcolor.SecondaryGreenr,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Available",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: Tcolor.PrimaryGreen,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "₦${price.toStringAsFixed(0)}", // Format price cleanly
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),

          // --- BOTTOM BUTTONS ---
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () { /* Navigate to DetailsPage */ },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Tcolor.PrimaryGreen,
                    side: BorderSide(color: Tcolor.PrimaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    "View details",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () { /* Handle Buy Now */ },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Tcolor.PrimaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}