import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_bar.dart';
//import '../controllers/mark_entry_provider.dart';
import '../controllers/mark_service.dart';
import '../providers/mark_entry_providers.dart';
import '../widgets/mark_entry_table.dart';
import '../widgets/student_mark_row.dart';
import '../widgets/mark_entry_bottom_bar.dart';
import '../widgets/mark_exam_info_card.dart';
import '../widgets/mark_entry_section_header.dart';

class MarkEntryScreen extends ConsumerWidget {
  final String examinationId;
  final String examinationName;
  final int? academicYear;
  final String className;
  final String subjectName;
  final int classSubjectId;

  const MarkEntryScreen({
    super.key,
    required this.examinationId,
    required this.examinationName,
    this.academicYear,
    required this.className,
    required this.subjectName,
    required this.classSubjectId,
  });

  int _parseClassId(String className) {
    final match = RegExp(r'\d+').firstMatch(className);
    return match != null ? int.parse(match.group(0)!) : 1;
  }

  MarkEntryArgs get _args => (
  examinationId: examinationId,
  classSubjectId: classSubjectId,
  classId: _parseClassId(className),
  );

  void _showMessage(
      BuildContext context,
      String message, {
        bool isError = false,
      }) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  Future<void> _publish(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(markEntryProvider(_args).notifier).save();
    if (!context.mounted) return;
    _showMessage(context, result.message, isError: !result.ok);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sheetAsync = ref.watch(markEntryProvider(_args));

    return Scaffold(
      appBar: const UserAppBar(),
      body: sheetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ডেটা লোড করতে সমস্যা হয়েছে:\n$error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => ref.invalidate(markEntryProvider(_args)),
                  child: const Text('আবার চেষ্টা করুন'),
                ),
              ],
            ),
          ),
        ),
        data: (sheet) => _buildBody(context, ref, sheet),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      WidgetRef ref,
      MarkEntryState sheet,
      ) {
    final notifier = ref.read(markEntryProvider(_args).notifier);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ১. পরীক্ষার তথ্য কার্ড
                MarkExamInfoCard(
                  examName: examinationName,
                  academicYear: academicYear?.toString() ?? 'N/A',
                  className: className,
                  subjectName: subjectName,
                ),
                const SizedBox(height: 12),

                // ২. এডিট বাটন
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    onPressed: notifier.toggleEditing,
                    icon: Icon(
                      sheet.isEditing ? Icons.check : Icons.edit_outlined,
                      size: 18,
                    ),
                    label: Text(sheet.isEditing ? 'Done' : 'Edit Marks'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2563EB),
                      side: const BorderSide(color: Color(0xFF2563EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ৩. সেকশন হেডার
                MarkEntrySectionHeader(
                  title: 'Student Marks Entry',
                  subtitle: 'Enter marks for each student',
                  trailing: Text(
                    '${sheet.students.length} Students',
                    style: const TextStyle(
                      color: Color(0xFF2563EB),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // ৪. স্টুডেন্ট মার্ক এন্ট্রি টেবিল
                MarkEntryTable(
                  children: [
                    for (final student in sheet.students)
                      StudentMarkRow(
                        key: ValueKey(student.roll),
                        roll: student.roll,
                        name: student.name,
                        mcqController: student.mcqController,
                        theoryController: student.theoryController,
                        practicalController: student.practicalController,
                        mcqMax: MarkService.mcqMax,
                        theoryMax: MarkService.theoryMax,
                        practicalMax: MarkService.practicalMax,
                        total: sheet.totalOf(student),
                        onMcqChanged: (_) => notifier.markChanged(),
                        onTheoryChanged: (_) => notifier.markChanged(),
                        onPracticalChanged: (_) => notifier.markChanged(),
                        isEditing: sheet.isEditing,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ৫. বটম বার
        MarkEntryBottomBar(
          enteredCount: sheet.enteredCount,
          totalStudents: sheet.students.length,
          onPublish: () => _publish(context, ref),
        ),
      ],
    );
  }
}