import 'package:flutter/material.dart';
import '../../../../core/constant/app_colors.dart';

class ExamPerformanceCard extends StatelessWidget {
  final String? examName;
  final String? academicYear;
  final String className;
  final String subjectName;

  const ExamPerformanceCard({
    super.key,
    this.examName,
    this.academicYear,
    required this.className,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD6E4FF),
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
          // যদি examName বা academicYear থাকে, তবে উপরে একটি হেডার বা এক্সাম ইনফো দেখাতে পারেন
          if (examName != null && examName!.isNotEmpty) ...[
            Row(
              children: [
                const Icon(Icons.assignment_outlined, size: 16, color: AppColors.primaryGradientStart),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'পরীক্ষা: $examName ${academicYear != null ? '($academicYear)' : ''}',
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],

          // ক্লাস ও সাবজেক্টের ইনফো চিপস
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _InfoChip(
                icon: Icons.school_outlined,
                label: 'ক্লাস: $className',
              ),
              _InfoChip(
                icon: Icons.menu_book_outlined,
                label: 'বিষয়: $subjectName',
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
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.cardBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryGradientStart, size: 16),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF334155),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}