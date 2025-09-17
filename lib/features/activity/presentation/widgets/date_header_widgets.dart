import 'package:flutter/material.dart';

class DateHeader extends StatelessWidget {
  final String dateText;
  const DateHeader({super.key, required this.dateText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Text(
            dateText,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}