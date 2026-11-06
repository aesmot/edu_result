import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../../features/student/presentation/providers/student_provider.dart';
import '../controllers/student_marks_ui.dart';
import '../widgets/mark_entry_table.dart';
import '../widgets/marking_note_card.dart';
import '../widgets/student_mark_row.dart';
import '../widgets/mark_entry_bottom_bar.dart';
import '../widgets/mark_exam_info_card.dart';
import '../widgets/mark_entry_section_header.dart'; // আপনার এই ছোট হেডার উইজেটটি

class MarkEntryScreen extends ConsumerStatefulWidget {
  final String examinationId;
  final String examinationName;
  final int? academicYear;
  final String className;
  final String subjectName;

  const MarkEntryScreen({
    super.key,
    required this.examinationId,
    required this.examinationName,
    this.academicYear,
    required this.className,
    required this.subjectName,
  });

  @override
  ConsumerState<MarkEntryScreen> createState() => _MarkEntryScreenState();
}

class _MarkEntryScreenState extends ConsumerState<MarkEntryScreen> {
  final List<StudentMarksUI> _students = [];
  bool _isInitialized = false;

  @override
  void dispose() {
    for (final student in _students) {
      student.dispose();
    }
    super.dispose();
  }

  int get completedStudents =>
      _students.where((student) => student.isComplete).length;

  int _parseClassId(String className) {
    final regExp = RegExp(r'\d+');
    final match = regExp.firstMatch(className);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return 1;
  }

  void _onMarkChanged() {
    setState(() {});
  }

  void _publishMarks() {
    final incompleteStudents =
    _students.where((student) => !student.isComplete).toList();

    if (incompleteStudents.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${incompleteStudents.length} student(s) have incomplete or invalid marks.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Validation successful for Exam ID: ${widget.examinationId}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classId = _parseClassId(widget.className);
    final studentsAsync = ref.watch(studentsByClassProvider(classId));

    return Scaffold(
      appBar: const UserAppBar(),
      body: studentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'স্টুডেন্ট লোড করতে সমস্যা হয়েছে:\n$error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (serverStudents) {
          if (!_isInitialized) {
            _students.clear();
            for (var s in serverStudents) {
              _students.add(
                StudentMarksUI(
                  roll: s.rollNumber,
                  name: s.name,
                  mcq: '',
                  theory: '',
                  practical: '', studentId: null,
                ),
              );
            }
            _isInitialized = true;
          }

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
                        examName: widget.examinationName,
                        academicYear: widget.academicYear?.toString() ?? 'N/A',
                        className: widget.className,
                        subjectName: widget.subjectName,
                      ),
                      const SizedBox(height: 12),

                      // ২. এডিট বাটন
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Saved marks editing will be connected later.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('Edit Existing Marks'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF2563EB),
                            side: const BorderSide(
                              color: Color(0xFF2563EB),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ৩. আপনার তৈরি করা ছোট সেকশন হেডার উইজেট
                      MarkEntrySectionHeader(
                        title: 'Student Marks Entry',
                        subtitle: 'Enter marks for each student',
                        trailing: Text(
                          '${_students.length} Students',
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
                          for (final student in _students)
                            StudentMarkRow(
                              key: ValueKey(student.rollNumber),
                              roll: student.rollNumber,
                              name: student.studentName,
                              mcqController: student.mcqController,
                              theoryController: student.theoryController,
                              practicalController: student.practicalController,
                              mcqMax: 25,
                              theoryMax: 50,
                              practicalMax: 25,
                              total: student.isPending ? null : student.total,
                              onMcqChanged: (_) => _onMarkChanged(),
                              onTheoryChanged: (_) => _onMarkChanged(),
                              onPracticalChanged: (_) => _onMarkChanged(),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ৫. নিচে মার্কিং নোট কার্ড
                      const MarkingNoteCard(),
                    ],
                  ),
                ),
              ),

              // ৬. বটম বার
              MarkEntryBottomBar(
                enteredCount: completedStudents,
                totalStudents: _students.length,
                onPublish: _publishMarks,
              ),
            ],
          );
        },
      ),
    );
  }
}