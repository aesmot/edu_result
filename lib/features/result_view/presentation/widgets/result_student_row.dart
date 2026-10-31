
import 'package:flutter/material.dart';

import 'grade_badge.dart';

class ResultStudentRow extends StatelessWidget {
  final String roll;
  final String name;
  final String total;
  final String grade;
  final String merit;

  const ResultStudentRow({
    super.key,
    required this.roll,
    required this.name,
    required this.total,
    required this.grade,
    required this.merit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEF0F5)),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(
              roll,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF555C75),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF303650),
              ),
            ),
          ),
          SizedBox(
            width: 85,
            child: Text(
              total,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF303650),
              ),
            ),
          ),
          SizedBox(
            width: 95,
            child: Align(
              alignment: Alignment.centerLeft,
              child: GradeBadge(grade: grade),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              merit, // <-- 'Merit: $merit' er bodole shudhu merit rakha holo
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: merit == '--'
                    ? const Color(0xFF9AA0B1)
                    : const Color(0xFF5B61D6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
