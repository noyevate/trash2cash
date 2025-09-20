import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';


class SellerInfoCard extends StatelessWidget {
  // In a real app, you'd pass a Seller object
  const SellerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  radius: 30.r,
                  // backgroundImage: NetworkImage(seller.imageUrl), // For real data
                  backgroundColor: Colors.grey,
                ),
                 12.b,
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Flores, Juanita", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4),
                        Text("(5.0)", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            const RText(title:"Phone Number", style: TextStyle(color: Colors.grey)),
            const RText(title:"08087654321", style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 12),
            const RText(title:"Location", style: TextStyle(color: Colors.grey)),
            RText(title:"123, Victoria Island Way, VI, Lagos", style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}