import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import '../../../teacher/dashboard/provider/teacher_class_provider.dart';
import '../providers/selected_class_subject_provider.dart';
import '../widgets/exam_performance_card.dart';
import '../widgets/teacher_result_list_table.dart';
import '../widgets/result_action_buttons.dart';

class TeacherResultScreen extends ConsumerStatefulWidget {
  final String? examName;
  final String? academicYear;
  final String? className;
  final String? subjectName;

  const TeacherResultScreen({
    super.key,
    this.examName,
    this.academicYear,
    this.className,
    this.subjectName,
  });

  @override
  ConsumerState<TeacherResultScreen> createState() =>
      _TeacherResultScreenState();
}

class _TeacherResultScreenState extends ConsumerState<TeacherResultScreen> {
  @override
  Widget build(BuildContext context) {
    // গ্লোবাল প্রোভাইডার থেকে সিলেক্ট করা ক্লাস ও সাবজেক্টের নাম পড়ুন
    final selectedClassName = ref.watch(selectedClassNameProvider);
    final selectedSubjectName = ref.watch(selectedSubjectNameProvider);

    // যদি প্রোভাইডারে নাম থাকে তবে সেটা দেখাবে, আর যদি সরাসরিConstructor থেকে আসে সেটাও হ্যান্ডেল করবে
    final displayClassName = selectedClassName ?? widget.className ?? 'ক্লাস সিলেক্ট করা নেই';
    final displaySubjectName = selectedSubjectName ?? widget.subjectName ?? 'বিষয় সিলেক্ট করা নেই';

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
                  const SizedBox(height: 8),
                  const _SectionHeading(
                    icon: Icons.bar_chart_rounded,
                    title: 'EXAM PERFORMANCE SUMMARY',
                  ),
                  const SizedBox(height: 12),

                  // সরাসরি পাস করে দিন
                  ExamPerformanceCard(
                    examName: widget.examName,
                    academicYear: widget.academicYear,
                    className: selectedClassName ?? widget.className ?? 'ক্লাস সিলেক্ট করা নেই',
                    subjectName: selectedSubjectName ?? widget.subjectName ?? 'বিষয় সিলেক্ট করা নেই',
                  ),

                  const SizedBox(height: 24),
                  const _SectionHeading(
                    icon: Icons.menu_book_rounded,
                    title: 'RESULT LIST',
                  ),
                  const SizedBox(height: 12),
                  const ResultListTable(),
                  const SizedBox(height: 24),
                  const ResultActionButtons(),
                  const SizedBox(height: 12),
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