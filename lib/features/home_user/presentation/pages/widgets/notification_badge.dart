import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationIconWithBadge extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onTap;
  final IconData icon;
  final double iconSize;
  final Color color;

  const NotificationIconWithBadge({
    super.key,
    required this.unreadCount,
    required this.onTap,
    required this.icon,
    this.iconSize = 24.0, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        // Allow the badge to draw outside the bounds of the icon if needed
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: color,
          ),

          // --- Layer 2: The Badge (only visible if count > 0) ---
          if (unreadCount > 0)
            Positioned(
              // Adjust these values to position the badge perfectly
              top: -15.h,
              right: -8.w,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Center(
                  child: Text(
                    // Show "9+" if the count is too high
                    unreadCount > 9 ? '9+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}