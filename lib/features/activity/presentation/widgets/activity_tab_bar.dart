import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/color_extension.dart';
import 'package:trash2cash/constants/others.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/features/activity/presentation/widgets/activity_tab_widget.dart';

class ActivityTabBar extends StatelessWidget {
  const ActivityTabBar({super.key, required this.tabController});
      // : _tabController = tabController;

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return TabBar(
          controller: tabController,
          // --- Key Styling Properties for this Design ---
          isScrollable: true, // Allows tabs to scroll horizontally
          tabAlignment: TabAlignment.start, // Aligns tabs to the left
          dividerColor: Colors.transparent, // Removes the bottom line
          indicatorColor: Colors.transparent, // We don't want the default indicator line
          indicatorWeight: 0.01, // A hack to make the indicator effectively invisible
          labelPadding: EdgeInsets.symmetric(horizontal: 4.w), // Space between tabs
          
          // --- Define the Tabs using a map ---
          tabs: List.generate(activityList.length, (index) {
            final isSelected = tabController.index == index;
            final title = activityList[index];

            // This is the individual tab chip
            return Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  // The main logic for changing color and border
                  color: isSelected ? Tcolor.PrimaryGreen : Tcolor.ActivityUnelectedFill,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    // The border is only visible when not selected
                    color: isSelected ? Colors.transparent : Tcolor.ActivityBorder,
                    width: 1.5,
                  ),
                ),
                child: RText(
                  title: title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    // Text color changes based on selection
                    color: isSelected ? Colors.white : Tcolor.PrimaryGreen,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
