
import 'package:flutter/material.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../widgets/exam_performance_card.dart';
import '../widgets/result_list_table.dart';
import '../widgets/result_action_buttons.dart';

class AdminResultScreen extends StatelessWidget {
  const AdminResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SectionHeading(
                    title: 'EXAM PERFORMANCE SUMMARY',
                    icon: Icons.bar_chart_rounded,
                  ),
                  SizedBox(height: 12),

                  ExamPerformanceCard(
                    examName: 'Half Yearly Examination',
                    academicYear: '2026',
                    className: '6',
                    subjectName: 'ICT',
                  ),

                  SizedBox(height: 24),

                  _SectionHeading(
                    title: 'STUDENT RESULT LIST',
                    icon: Icons.menu_book_rounded,
                  ),
                  SizedBox(height: 12),

                  ResultListTable(),

                  SizedBox(height: 24),

                  ResultActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeading({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF5B61D6),
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: Color(0xFF303650),
            ),
          ),
        ),
      ],
    );
  }
}
