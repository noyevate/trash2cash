import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';

class CustomRecylerBottomNavBar extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  const CustomRecylerBottomNavBar({
    Key? key,
    required this.onTabSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FAB size and cut-out size
 

    return SizedBox(
      height: 60.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Navbar background
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: Tcolor.CustomNarBar,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black12,
              //     blurRadius: 8,
              //     offset: Offset(0, -2),
              //   ),
              // ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(null ,Ionicons.home_outline, "Dashboard", 0, ),
                _buildNavItem( Image.asset("images/Checklist.png"),   null, "Activity", 1),
                _buildNavItem(null, Ionicons.book_outline, "Education", 2),
                _buildNavItem(null, Ionicons.settings_outline, "Setting", 3),
              ],
            ),
          ),

          // Circle cut-out
          
        ],
      ),
    );
  }

  Widget _buildNavItem(Image? image, IconData? icon, String label, int index) {
    final isSelected = selectedIndex == index;
    

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        icon != null ? Icon(
            icon,
            color: isSelected ? Colors.green : Colors.grey,
            size: 18.sp,
          ) : Image.asset("images/Checklist.png", color: isSelected ? Colors.green : Colors.grey,),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}