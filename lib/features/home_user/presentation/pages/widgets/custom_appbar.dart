import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/home_user/presentation/pages/widgets/notification_badge.dart';
import 'package:trash2cash/features/notification/presentation/bloc/notification_badge_bloc.dart';
import 'package:trash2cash/features/notification/presentation/pages/notification.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    final String? imageUrl = box.read<String>('imageUrl');
    return Container(
      padding: EdgeInsets.only(
        right: 10.w,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: imageUrl != null  ? Image.network(
      imageUrl,
      fit: BoxFit.cover,
      width: 100, // Double the radius
      height: 100,
      // Add loading and error builders for a great UX
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : const CircularProgressIndicator(),
      errorBuilder: (context, error, stackTrace) =>
          // If the network image fails to load, you can even fall back to the asset
          Image.asset("images/home_image.png", fit: BoxFit.cover),
    )
  
  // --- ELSE (if imageUrl is null or empty), build an Image.asset ---
  : Image.asset(
      "images/home_image.png",
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    ),
                ),
              ),
              5.b,
              RText(
                  title: "Welcome, ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500)),
              RText(
                  title: name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          BlocBuilder<NotificationBadgeBloc, NotificationBadgeState>(
            builder: (context, state) {
              return NotificationIconWithBadge(
                icon: Ionicons.notifications_outline,
                color: Colors.black54,
                iconSize: 18.sp,
                unreadCount: state.count, // Pass the hardcoded count
                onTap: () {
                  print(state.count);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()),
                  );
                },
              );
            },
          ),

          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationPage()));
          //     },
          //     icon: Icon(
          //       Ionicons.notifications_outline,
          //       size: 18.sp,
          //     ))
        ],
      ),
    );
  }
}
