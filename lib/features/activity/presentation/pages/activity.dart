import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart';
import 'package:trash2cash/features/activity/domain/entities/activity_item.dart';
import 'package:trash2cash/features/activity/presentation/widgets/activity_card.dart';
import 'package:trash2cash/features/activity/presentation/widgets/activity_data.dart';
import 'package:trash2cash/features/activity/presentation/widgets/activity_list_tab.dart';
import 'package:trash2cash/features/activity/presentation/widgets/activity_tab_bar.dart';

class Activity extends StatefulWidget {
  const Activity({super.key, this.selectedIndex});
  final int? selectedIndex;

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: activityList.length, vsync: this);

    if (widget.selectedIndex != null) {
      // Set initial tab index if provided
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tabController.animateTo(widget.selectedIndex!);
      });
    }

    // final controller = Get.put(OrderController());
    // controller.setTabController(_tabController);

    _tabController.addListener(() {
      setState(() {}); // triggers rebuild when switching tabs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(180.h),
            child: Container(
              decoration: BoxDecoration(color:  const Color(0xffFCCC3E)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  30.l,
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                    child: RText(
                      title: "Activity",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
                    child: RText(
                      title: "Track your waste listings, sales, and payouts.",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Color(0xff6A7282),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  10.l,
                  Divider(
                    thickness: 1,
                    color: Color(0xffF3F4F6),
                  ),
                  ActivityTabBar(
                    tabController: _tabController,
                  )
                ],
              ),
            )),
        body: SizedBox(
          child: TabBarView(controller: _tabController, children: [
             ActivityListTab(type: ActivityType.ALL),
          ActivityListTab(type: ActivityType.PAID),
          ActivityListTab(type: ActivityType.SCHEDULED),
          ActivityListTab(type: ActivityType.COMPLETED),
          ]),
        ));
  }



  Widget _buildActivityList(List<ActivityData> activities) {
    // If a list is empty, show a message
    if (activities.isEmpty) {
      return const Center(
        child: Text(
          "No activities in this category.",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }
    
    // Use ListView.builder for performance
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];

        // --- Use a switch statement to build the correct card for each status ---
        switch (activity.status) {
          case 'PAID':
            return ActivityCard(
              icon: Icons.recycling,
              iconColor: Colors.green,
              title: activity.title,
              timestamp: "10:45 AM", // Replace with real data
              statusText: "Paid",
              statusColor: Colors.green.shade300,
              description: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
                  children: const [
                    TextSpan(text: "A recycler has paid "),
                    TextSpan(
                      text: "₦45,000",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    TextSpan(text: " for your waste."),
                  ],
                ),
              ),
              buttonText: "View Details",
              onButtonPressed: () {},
            );
          case 'SCHEDULED':
            return ActivityCard(
              icon: Icons.local_shipping_outlined,
              iconColor: Colors.orange.shade400,
              title: activity.title,
              timestamp: "9:30 AM", // Replace with real data
              statusText: "Scheduled",
              statusColor: Colors.orange.shade200,
              description: Text(
                "Michael Recycling scheduled pickup for\nAug 22, 9:00 AM.",
                style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
              ),
              buttonText: "View Schedule",
              onButtonPressed: () {},
            );
          case 'COMPLETED':
            return ActivityCard(
              icon: Icons.check_circle_outline,
              iconColor: Colors.blue,
              title: activity.title,
              timestamp: "Yesterday", // Replace with real data
              statusText: "Completed",
              statusColor: Colors.lightBlue,
              description: Text(
                "Michael Recycling has confirmed pickup.",
                style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.4),
              ),
              buttonText: "View Invoice",
              onButtonPressed: () {},
            );
          default:
            // A fallback for any other status type
            return const SizedBox.shrink();
        }
      },
    );
  }
}
