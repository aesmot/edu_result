
import 'package:flutter/material.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../../../../shared/widgets/section_heading.dart';
import 'class_result_summary_card.dart';
import '../widgets/teacher_result_list_table.dart';
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
                children: [
                  // Exam Information Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4C9EEB),
                          Color(0xFF6B4EE6),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4C9EEB)
                              .withValues(alpha: 0.18),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.assessment_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 16),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EXAM PERFORMANCE SUMMARY',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),

                              SizedBox(height: 7),

                              Text(
                                'Annual Examination',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 5),

                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.white70,
                                    size: 15,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Academic Year 2026',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.school_rounded,
                          color: Colors.white24,
                          size: 48,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Class-wise Result Overview
                  const SectionHeading(
                    title: 'CLASS-WISE RESULT OVERVIEW',
                    icon: Icons.menu_book_rounded,
                  ),

                  const SizedBox(height: 14),

                  ClassResultSummaryCard(
                    className: 'Class 9',
                    totalStudents: 50,
                    passed: 45,
                    failed: 5,
                    passRate: 90,
                    status: 'Published',
                    onViewResults: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: UserAppBar(),
                            body: const SafeArea(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: ResultListTable(),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // More class cards can be added here.

                  const SizedBox(height: 26),

                  // Print Result
                  const SectionHeading(
                    title: 'PRINT YOUR RESULT',
                    icon: Icons.print_rounded,
                  ),

                  const SizedBox(height: 14),

                  const ResultActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
