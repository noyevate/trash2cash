import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:trash2cash/features/notification/presentation/widgets/notification_card.dart';
import 'package:trash2cash/features/notification/presentation/widgets/notification_details.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../constants/color_extension.dart';
import '../../domain/entities/notiication_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch notifications as soon as the page is created.
    context.read<NotificationBloc>().add(FetchNotificationsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(180.h),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xffFCCC3E)),
            child: SafeArea(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                          title: "Notifications",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: RText(
                        title: "Mark all as read",
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xff279B54),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadInProgress ||
              state is NotificationInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationLoadFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Failed to load notifications: ${state.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<NotificationBloc>()
                          .add(FetchNotificationsRequested());
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }

          if (state is NotificationLoadSuccess) {
            if (state.notifications.isEmpty) {
              return const Center(
                  child: Text("You don't have any notifications yet."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.notifications.length,
              itemBuilder: (context,index) {
                final notification = state.notifications[index];

                return NotificationCard(
                  icon: _getIconForTitle(notification.title),
                  iconBackgroundColor: _getIconColorForTitle(notification.title),
                  cardColor: _getCardColor(notification),
                  isRead: notification.isRead,
                  title: notification.title,
                  description: notification.message,
                  timestamp: timeago.format(notification.createdAt),
                  onTap: () {},
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

 IconData _getIconForTitle(String title) {
    if (title.toLowerCase().contains('payment')) return Ionicons.cash_outline;
    if (title.toLowerCase().contains('withdrawal')) return Ionicons.card_outline;
    if (title.toLowerCase().contains('pickup')) return Ionicons.cube_outline;
    if (title.toLowerCase().contains('milestone')) return Ionicons.trophy_outline;
    if (title.toLowerCase().contains('recycler')) return Ionicons.person_add_outline;
    return Ionicons.notifications_outline; // Default
  }

  Color _getIconColorForTitle(String title) {
    if (title.toLowerCase().contains('payment') || title.toLowerCase().contains('pickup')) {
      return CardColors.primaryGreen;
    }
    if (title.toLowerCase().contains('milestone')) {
      return const Color(0xffFBC02D); // Gold
    }
    if (title.toLowerCase().contains('withdrawal')) {
      return CardColors.primaryBlue;
    }
    return Colors.grey.shade500;
  }

  Color _getCardColor(NotificationItem notification) {
    // Only give special background colors to unread notifications
    if (!notification.isRead) {
      if (notification.title.toLowerCase().contains('payment')) return CardColors.lightGreen;
      if (notification.title.toLowerCase().contains('pickup')) return CardColors.lightYellow;
      if (notification.title.toLowerCase().contains('milestone')) return CardColors.lightYellow;
    }
    // Default to white for all read notifications and other types
    return Colors.white;
  }

