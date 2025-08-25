import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/r_text.dart';

class DetailsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String type;
  final String weight;
  final String status; // e.g., "paid" or "pending"

  const DetailsPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.type,
    required this.weight,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RText(
          title: "Waste Details",
          style: TextStyle(color: Colors.black, fontSize: 24.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Ionicons.arrow_back_circle_outline,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context), // goes back
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      color: status == "paid"
                          ? Colors.greenAccent
                          : Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text(
                  type,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(width: 5.w),
                CircleAvatar(
                  radius: 2,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 5.w),
                Text(
                  weight,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            Text(
              "Description",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 10.h),
            RText(
              title: "Here you can add extra details about the item, transaction, or order. "
              "For example: location, delivery status, payment method, or notes.",
              style: TextStyle(color: Colors.grey[700], fontSize: 12.sp),
            ),
            SizedBox(height: 25.h),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size(double.infinity, 50.h),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12.r)),
            //     backgroundColor: Colors.green,
            //   ),
            //   onPressed: () {
            //     // Action (e.g., download receipt, confirm, etc.)
            //   },
            //   child: Text("Take Action",
            //       style: TextStyle(
            //           fontSize: 14.sp,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white)),
            // )
          ],
        ),
      ),
    );
  }
}
