
import 'package:flutter/material.dart';

/// Displays column headings for the student marks table.
class MarkEntryTableHeader extends StatelessWidget {
  const MarkEntryTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4C9EEB),
            Color(0xFF6B4EE6),
          ],
        ),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              'Roll',
              textAlign: TextAlign.center,
              style: _headerStyle,
            ),
          ),
          //SizedBox(width: 8),

          SizedBox(
            width: 160,
            child: Text(
              'Student Name',
              style: _headerStyle,
            ),
          ),

          //SizedBox(width: 2),

          SizedBox(
            width: 58,
            child: Center(
              child: Text('MCQ', style: _headerStyle),
            ),
          ),

          //SizedBox(width: 6),

          SizedBox(
            width: 58,
            child: Center(
              child: Text('Theory', style: _headerStyle),
            ),
          ),

          SizedBox(width: 6),

          SizedBox(
            width: 58,
            child: Center(
              child: Text('Practical', style: _headerStyle),
            ),
          ),

          SizedBox(width: 20),

          SizedBox(
            width: 42,
            child: Text(
              'Total',
              textAlign: TextAlign.center,
              style: _headerStyle,
            ),
          ),
        ],
      ),
    );
  }
}

const _headerStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
  fontWeight: FontWeight.w900,
);
