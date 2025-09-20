import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      // padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("images/home_image.png"),
              6.b,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                  RText(
                      title: "Here are new waste listings near you.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400)),
                ],
              ),
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
        ],
      ),
    );
  }
}
