import 'package:flutter/material.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../widgets/exam_performance_card.dart';
import '../widgets/result_list_table.dart';
import '../widgets/result_action_buttons.dart';

class TeacherResultScreen extends StatelessWidget {
  const TeacherResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF5F7FC),
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
                  SizedBox(height: 8), // Top padding balance kora holo
                  _SectionHeading(
                    icon: Icons.bar_chart_rounded,
                    title: 'EXAM PERFORMANCE SUMMARY',
                  ),
                  SizedBox(height: 12), // Heading ebong card er majher gap standard rakha holo
                  ExamPerformanceCard(
                    examName: 'Half Yearly Examination',
                    academicYear: '2026',
                    className: '6',
                    subjectName: 'ICT / Science',
                  ),
                  SizedBox(height: 24), // First section sheshe comfortable gap
                  _SectionHeading(
                    icon: Icons.menu_book_rounded,
                    title: 'RESULT LIST',
                  ),
                  SizedBox(height: 12), // Heading ebong table er majher gap
                  ResultListTable(),
                  SizedBox(height: 24), // Table ebong bottom action buttons er gap
                  ResultActionButtons(),
                  SizedBox(height: 12), // Bottom-most padding extra breathing room er jonno
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
  final IconData icon;
  final String title;

  const _SectionHeading({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF5B61D6), size: 22),
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