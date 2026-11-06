
import 'package:flutter/material.dart';

import '../../../action_management/screen/assign_subject_class_manage/assign_subject_class_manage_screen.dart';
import '../../../action_management/screen/marks_grade_management/screens/class_wise_mark_management_screen.dart';
import '../../../action_management/screen/result_manage/manage_results_screen.dart';
import '../../../action_management/widget/teacher_list_screen.dart';

class AdminQuickActionsSection extends StatelessWidget {
  const AdminQuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> actions = [

      {
        'title': 'Master Result Reports & Approval',
        'subtitle': 'Review results and give final approval',
        'icon': Icons.insights_rounded,
        'color': const Color(0xFFEF4444),
        'bgColor': const Color(0xFFF8FAFC),
        'iconBg': const Color(0xFFFEE2E2),
        'page': ManageResultsScreen(),
      },
      {
        'title': 'Manage Teachers',
        'subtitle': 'Add, edit or remove teachers and users',
        'icon': Icons.people_rounded,
        'color': const Color(0xFF2563EB),
        'bgColor': const Color(0xFFF8FAFC),
        'iconBg': const Color(0xFFDBEAFE),
        'page':  TeacherListScreen(),
      },
      {
        'title': 'Assign Classes & Subjects',
        'subtitle': 'Manage class distribution and subject assignment',
        'icon': Icons.menu_book_rounded,
        'color': const Color(0xFF10B981),
        'bgColor': const Color(0xFFF8FAFC),
        'iconBg': const Color(0xFFD1FAE5),
        'page': AssignClassSubjectScreen(),

      },
      {
        'title': 'Marks & Grade Calculation',
        'subtitle': 'Setup mark, define total marks and grade',
        'icon': Icons.note_add_rounded,
        'color': const Color(0xFF8B5CF6),
        'bgColor': const Color(0xFFF8FAFC),
        'iconBg': const Color(0xFFEDE9FE),
        'page': ClassWiseMarkManagementScreen(),
      },

    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header

        const SizedBox(height: 12),

        // Actions List
        ListView.separated(
          itemCount: actions.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) =>
          const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final action = actions[index];
            final Color mainColor = action['color'] as Color;

            return InkWell(
              onTap: () {
                // Add navigation or action here.

                  // পেজ ডিফাইন করা থাকলে নেভিগেট করবে
                  if (action['page'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => action['page'] as Widget,
                      ),
                    );
                  }
                },

              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: action['bgColor'] as Color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: mainColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Icon Box
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: action['iconBg'] as Color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        action['icon'] as IconData,
                        color: mainColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Title & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            action['title'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            action['subtitle'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow Icon
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
