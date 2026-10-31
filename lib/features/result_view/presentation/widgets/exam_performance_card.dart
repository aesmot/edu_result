import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';

class ExamPerformanceCard extends StatelessWidget {
  final String examName;
  final String academicYear;
  final String className;
  final String subjectName;

  const ExamPerformanceCard({
    super.key,
    required this.examName,
    required this.academicYear,
    required this.className,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Halkha ba soft color background (Light blue tint)
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD6E4FF), // Shundor soft border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            '$examName ($academicYear)',
            style: const TextStyle(
              color: Color(0xFF1E293B), // Dark professional text
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoChip(
                icon: Icons.school_outlined,
                label: 'Class: $className',
              ),
              _InfoChip(
                icon: Icons.menu_book_outlined,
                label: 'Subject: $subjectName',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white, // Chip gulo white background-e thakbe
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          //color: const Color(0xFFD6E4FF),
          color: AppColors.cardBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryGradientStart, size: 16), // Primary theme color icon
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF334155), // Dark text for high readability
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}