import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/constom_recycler_bottom_nav_bar.dart';
import 'package:trash2cash/features/recycler_activity/presentation/pages/activity.dart';
import 'package:trash2cash/features/recycler_home/presentation/pages/btom_nave_pages/education.dart';
import 'package:trash2cash/features/recycler_home_dashboard/presentation/pages/home_dashboard.dart';
import 'package:trash2cash/features/recycler_home/presentation/pages/btom_nave_pages/settings.dart';

class RecyclerHome extends StatefulWidget {
  const RecyclerHome({super.key});

  @override
  State<RecyclerHome> createState() => _RecyclerHomeState();
}

class _RecyclerHomeState extends State<RecyclerHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeDashboard(),
    Activity(),
    Education(),
    Settings()
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      
      
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
        child: CustomRecylerBottomNavBar(
          selectedIndex: _selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}