// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:trash2cash/constants/color_extension.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final Function(int) onTabSelected;
//   final int selectedIndex;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.onTabSelected,
//     required this.selectedIndex,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // Background with custom shape
//         Container(
//           height: 60.h,
//           decoration: BoxDecoration(
//             color: Tcolor.CustomNarBar,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40),
//               topRight: Radius.circular(40),
//               bottomLeft: Radius.circular(40),
//               bottomRight: Radius.circular(40),
//             ),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: Colors.black12,
//             //     blurRadius: 8,
//             //     offset: Offset(0, -2),
//             //   ),
//             // ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(Ionicons.home_outline, "Dashboard", 0),
//                SizedBox(width: 40), // leave space for FAB cut-out
//               _buildNavItem(Ionicons.settings_outline, "Setting", 1),
//             ],
//           ),
//         ),

//         // Circular cut-out for FAB
//         Positioned(
//           top: -30,
//           left: MediaQuery.of(context).size.width / 2 - 30,
//           right: 135,
//           child: Container(
//             width: 80,
//             height: 80,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = selectedIndex == index;

//     return GestureDetector(
//       onTap: () => onTabSelected(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: isSelected ? Colors.green : Colors.grey,
//             size: 18.sp,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.green : Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/color_extension.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.onTabSelected,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FAB size and cut-out size
    double fabSize = 50.sp; // default FloatingActionButton size
    double extraSpace = 40.sp; // make cut-out wider than FAB
    double circleSize = fabSize + extraSpace;

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
                const SizedBox(width: 60), // space for FAB cut-out
                _buildNavItem(null, Ionicons.book_outline, "Education", 2),
                _buildNavItem(null, Ionicons.settings_outline, "Setting", 3),
              ],
            ),
          ),

          // Circle cut-out
          Positioned(
            top: -20,
            right: 100,
            left: MediaQuery.of(context).size.width / 3 - (20.w /5 ),
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
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