import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/features/profile/presentation/pages/profile_setup_page.dart';
import 'package:trash2cash/features/profile/presentation/pages/recycler_profile_setup.dart';

class CreateRecyclerAccountModal extends StatelessWidget {
  const CreateRecyclerAccountModal({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your primary green color for consistency
    const Color primaryGreen = Color(0xff2E7D32);

    return Dialog(
      backgroundColor: Colors.white,
      // Gives the dialog its rounded corners
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          // Makes the column height fit its content
          mainAxisSize: MainAxisSize.min, 
          // Aligns the text to the left, as shown in the image
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
             RText(
              title: "Complete",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            RText(
              title: "Your Account",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
             RText(
              title: "Setup",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // --- DESCRIPTION ---
            const Text(
              "Complete your profile to start buying waste and scheduling pickups securely.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5, // Improves readability
              ),
            ),
            const SizedBox(height: 24),

            // --- PRIMARY BUTTON ---
            SizedBox(
              width: double.infinity, // Makes the button full-width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => RecyclerProfileSetup()));
                },
                child: const Text(
                  "Set up Account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // --- SECONDARY "DO IT LATER" BUTTON ---
            Center(
              child: TextButton(
                onPressed: () {
                  print("Doing it later...");
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  "Do it later",
                  style: TextStyle(
                    color: primaryGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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