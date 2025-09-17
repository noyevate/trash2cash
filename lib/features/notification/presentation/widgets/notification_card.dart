import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/r_text.dart';

// --- Placeholder for your theme colors ---
class CardColors{
  static const  primaryGreen = Color(0xff2E7D32);
  static const  lightGreen = Color(0xffE8F5E9);
  static const  lightYellow = Color(0xffFFFDE7);
  static const  primaryBlue = Color(0xff1565C0);
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String description;
  final String timestamp;
  final bool isRead;
  final Color cardColor;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = false,
    this.cardColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.08),
        margin: EdgeInsets.only(bottom: 15.sp),
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- The Icon ---
              CircleAvatar(
                radius: 20.r,
                backgroundColor: iconBackgroundColor,
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 16),
              // --- The Text Content ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Title
                        Expanded(
                          child: RText(
                            title: title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        // "Unread" dot
                        if (!isRead) ...[
                          const SizedBox(width: 8),
                          const CircleAvatar(
                            radius: 4,
                            backgroundColor: CardColors.primaryGreen,
                          ),
                        ]
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Description
                    Text(
                    description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                        fontFamily: 'Metropolis'
                      ),
                      
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Timestamp
                    RText(
                     title: timestamp,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}