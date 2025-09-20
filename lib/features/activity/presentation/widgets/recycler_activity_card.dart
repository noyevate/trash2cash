import 'package:flutter/material.dart';
import 'package:trash2cash/constants/color_extension.dart';



class RecyclerActivityCard extends StatelessWidget {
  final String title;
  final String timestamp;
  final String description;
  final VoidCallback onButtonPressed;

  const RecyclerActivityCard({
    super.key,
    required this.title,
    required this.timestamp,
    required this.description,
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
            // --- Top Row: Icon, Title, and Timestamp ---
            Row(
              children: [
                // Icon
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Tcolor.PrimaryGreen,
                  child: Icon(Icons.recycling, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
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
            const SizedBox(height: 12),

            // --- Middle Section: Description ---
            Padding(
              padding: const EdgeInsets.only(left: 56.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Bottom Section: Button ---
            Padding(
              padding: EdgeInsets.only(left: 56.0),
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Tcolor.PrimaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                child: const Text(
                  "Schedule Pickup",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}