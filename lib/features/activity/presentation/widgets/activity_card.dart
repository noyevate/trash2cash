import 'package:flutter/material.dart';

// --- Placeholder for your theme colors ---
class Tcolor {
  static const Color primaryGreen = Color(0xff2E7D32);
  static const Color lightGreen = Color(0xffE0F2F1); // For the "Paid" tag
  static const Color primaryOrange = Color(0xffF57C00);
  static const Color lightOrange = Color(0xffFFF3E0); // For the "Scheduled" tag
  static const Color primaryBlue = Color(0xff1976D2);
  static const Color lightBlue = Color(0xffE3F2FD); // For the "Completed" tag
}

// --- THE REUSABLE ACTIVITY CARD WIDGET ---

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String timestamp;
  final String statusText;
  final Color statusColor;
  final Widget description; // Use Widget for flexibility (e.g., RichText)
  final String buttonText;
  final VoidCallback onButtonPressed;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.timestamp,
    required this.statusText,
    required this.statusColor,
    required this.description,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top Row: Icon, Title, Timestamp, and Status Tag ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                CircleAvatar(
                  radius: 22,
                  backgroundColor: iconColor,
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                // Title and Description Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Timestamp
                          Text(
                            timestamp,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Status Tag
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              color: iconColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // --- Middle Section: Description ---
            Padding(
              // Indent the description to align with the title
              padding: const EdgeInsets.only(left: 56.0), 
              child: description,
            ),
            const SizedBox(height: 16),

            // --- Bottom Section: Button ---
            Padding(
              padding: const EdgeInsets.only(left: 56.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton(
                  onPressed: onButtonPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Tcolor.primaryGreen,
                    side: const BorderSide(color: Tcolor.primaryGreen, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}