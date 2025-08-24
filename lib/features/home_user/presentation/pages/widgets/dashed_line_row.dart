import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash2cash/constants/r_text.dart';

class DashedLineRow extends StatelessWidget {
  final String leftText;

  const DashedLineRow({
    super.key,
    required this.leftText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left text
        RText(
          title: leftText,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
        ),


        // Dashed line expands in the middle
        Expanded(
          child: CustomPaint(
            painter: DashedLinePainter(),
            child: const SizedBox(height: 20),
          ),
        ),        
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;

    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
