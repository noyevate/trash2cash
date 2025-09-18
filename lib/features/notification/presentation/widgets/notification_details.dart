import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:trash2cash/constants/r_text.dart';
import 'package:trash2cash/constants/space_exs.dart'; // Needed for Clipboard

// --- Placeholder for your theme colors ---
class Tcolor {
  static const Color primaryGreen = Color(0xff2E7D32);
}

// --- THE NOTIFICATION DETAILS PAGE WIDGET ---

class NotificationDetailsPage extends StatelessWidget {
  final String appBarTitle;
  final String mainTitle;
  // final String recyclerName;
  // final String wasteAmount;
  // final String wasteType;
  // final String wasteId;
  final String secondaryText;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const NotificationDetailsPage({
    super.key,
    required this.appBarTitle,
    required this.mainTitle,
    // required this.recyclerName,
    // required this.wasteAmount,
    // required this.wasteType,
    // required this.wasteId,
    required this.secondaryText,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Define text styles for reuse
    const normalTextStyle = TextStyle(
        fontSize: 15,
        color: Colors.black54,
        height: 1.5, // Line spacing
        fontFamily: "Metropolis");
    const boldTextStyle = TextStyle(
        fontSize: 15,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        height: 1.5,
        fontFamily: "Metropolis");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.h),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Ionicons.arrow_back_circle_outline,
                      color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                RText(
                  title: appBarTitle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            // --- Main Title ---
            RText(
              title: mainTitle,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),

            // --- Mixed-style Description using RichText ---
            // RichText(
            //   text: TextSpan(
            //     style: normalTextStyle,
            //     children: [
            //       TextSpan(text: "$recyclerName has paid for your waste "),
            //       TextSpan(text: "$wasteAmount of ", style: boldTextStyle),
            //       TextSpan(text: wasteType, style: boldTextStyle),
            //       const TextSpan(text: " with id "),
            //       TextSpan(
            //         text: wasteId,
            //         style: const TextStyle(
            //           color: Tcolor.primaryGreen,
            //           fontWeight: FontWeight.bold,
            //           decoration: TextDecoration.underline,
            //           fontFamily: "Metropolis"
            //         ),
            //         // Make the ID tappable to copy
            //         // recognizer: TapGestureRecognizer()
            //         //   ..onTap = () {
            //         //     Clipboard.setData(ClipboardData(text: wasteId));
            //         //     ScaffoldMessenger.of(context).showSnackBar(
            //         //       const SnackBar(
            //         //           content: Text('ID copied to clipboard!')),
            //         //     );
            //         //   },
            //       ),
            //       const TextSpan(text: ".\n\n"), // Add a period and line breaks
            //       TextSpan(text: secondaryText),
            //     ],
            //   ),
            // ),
            // Pushes the button to the bottom

            RText(
              title: secondaryText, 
              style: normalTextStyle,
              overflow: TextOverflow.visible,
            ),
            20.l,
            // --- Action Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Tcolor.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: RText(
                  title: buttonText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            40.l, // Bottom padding
          ],
        ),
      ),
    );
  }
}
