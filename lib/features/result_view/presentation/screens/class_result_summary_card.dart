import 'package:flutter/material.dart';
import 'package:result_management_system/core/constant/app_colors.dart';

import '../widgets/admin_result_view_widget/stat_card.dart';

class ClassResultSummaryCard extends StatelessWidget {
  final String className;
  final int totalStudents;
  final int passed;
  final int failed;
  final double passRate;
  final String status;
  final VoidCallback? onViewResults;

  const ClassResultSummaryCard({
    super.key,
    required this.className,
    required this.totalStudents,
    required this.passed,
    required this.failed,
    required this.passRate,
    required this.status,
    this.onViewResults,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPublished = status.toLowerCase() == 'published';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Class name and publication status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                className,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isPublished
                      ? const Color(0xFFE8F8EF)
                      : const Color(0xFFFFF4DD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPublished
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFD97706),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Statistics Cards (Icon on the left)
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Total',
                  value: totalStudents.toString(),
                  icon: Icons.people_outline_rounded,
                  bgColor: const Color(0xFFF4F7FE),
                  iconColor: const Color(0xFF3B82F6),
                  textColor: const Color(0xFF1D4ED8),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  title: 'Passed',
                  value: isPublished ? passed.toString().padLeft(2, '0') : '--',
                  icon: Icons.check_circle_outline_rounded,
                  bgColor: const Color(0xFFEDFBF3),
                  iconColor: const Color(0xFF16A34A),
                  textColor: const Color(0xFF15803D),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  title: 'Failed',
                  value: isPublished ? failed.toString().padLeft(2, '0') : '--',
                  icon: Icons.cancel_outlined,
                  bgColor: const Color(0xFFFFF1F2),
                  iconColor: const Color(0xFFEF4444),
                  textColor: const Color(0xFFB91C1C),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  title: 'Pass Rate',
                  value: isPublished ? '${passRate.toStringAsFixed(0)}%' : '--',
                  icon: Icons.pie_chart_outline_rounded,
                  bgColor: const Color(0xFFF5F3FF),
                  iconColor: const Color(0xFF8B5CF6),
                  textColor: const Color(0xFF6D28D9),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: Colors.grey.shade200),
          const SizedBox(height: 12),

          // View results action
          Align(
            alignment: Alignment.centerRight,
            child: isPublished
                ? InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: onViewResults,
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All Results',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            )
                : Text(
              'Results not published',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
