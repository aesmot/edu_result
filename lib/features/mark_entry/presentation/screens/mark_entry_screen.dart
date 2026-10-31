
import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../widgets/mark_exam_info_card.dart';
import '../widgets/mark_entry_section_header.dart';
import '../widgets/mark_entry_table.dart';
import '../widgets/student_mark_row.dart';
import '../widgets/mark_entry_bottom_bar.dart';

class MarkEntryScreen extends StatefulWidget {
  const MarkEntryScreen({super.key});

  @override
  State<MarkEntryScreen> createState() => _MarkEntryScreenState();
}

class _MarkEntryScreenState extends State<MarkEntryScreen> {
  final List<_StudentMarksUI> students = [
    _StudentMarksUI(
      roll: '01',
      name: 'Md. Abdullah',
      mcq: '20',
      theory: '42',
      practical: '22',
    ),
    _StudentMarksUI(
      roll: '02',
      name: 'Tanvir Hasan',
      mcq: '18',
      theory: '35',
      practical: '20',
    ),
    _StudentMarksUI(
      roll: '03',
      name: 'Rayhan Ahmed',
      mcq: '24',
      theory: '48',
      practical: '25',
    ),
    _StudentMarksUI(
      roll: '04',
      name: 'Nusrat Jahan',
      mcq: '15',
      theory: '30',
      practical: '18',
    ),
    _StudentMarksUI(
      roll: '05',
      name: 'Shakil Hossain',
      mcq: '',
      theory: '',
      practical: '',
    ),
  ];

  int get completedStudents =>
      students.where((student) => student.isComplete).length;

  @override
  void dispose() {
    for (final student in students) {
      student.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFFF8FAFC),
      appBar: UserAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MarkExamInfoCard(
                    examName: 'Half Yearly Examination',
                    academicYear: '2026',
                    className: '6',
                    subjectName: 'ICT / Science',
                  ),
                  const SizedBox(height: 12),

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



/////////////////////////////////////
                  const SizedBox(height: 20),
                  MarkEntrySectionHeader(
                    title: 'Student Marks Entry',
                    subtitle: 'Enter marks for each student',
                    trailing: Text(
                      '${students.length} Students',
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  MarkEntryTable(
                    children: [

                      for (final student in students)
                        StudentMarkRow(
                          key: ValueKey(student.roll),
                          roll: student.roll,
                          name: student.name,
                          mcqController: student.mcqController,
                          theoryController: student.theoryController,
                          practicalController:
                          student.practicalController,
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
                  _buildMarkingNote(),


                ],
              ),
            ),
          ),
          MarkEntryBottomBar(
            enteredCount: completedStudents,
            totalStudents: students.length,
            onPublish: _publishMarks,
          ),
        ],
      ),
    );
  }



  Widget _buildMarkingNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC7D7FE),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF2563EB),
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'MCQ: 25 marks • Theory: 50 marks • Practical: 25 marks',
              style: TextStyle(
                color: Color(0xFF1E40AF),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMarkChanged() {
    setState(() {});
  }

  void _publishMarks() {
    final incompleteStudents =
    students.where((student) => !student.isComplete).toList();

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

    // Demo UI only: no marks are saved to the database yet.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Validation successful. Database publishing is not connected yet.',
        ),
      ),
    );
  }
}

/// Temporary model for demonstrating mark entry before repository integration.
class _StudentMarksUI {
  _StudentMarksUI({
    required this.roll,
    required this.name,
    required String mcq,
    required String theory,
    required String practical,
  })  : mcqController = TextEditingController(text: mcq),
        theoryController = TextEditingController(text: theory),
        practicalController = TextEditingController(text: practical);

  final String roll;
  final String name;

  final TextEditingController mcqController;
  final TextEditingController theoryController;
  final TextEditingController practicalController;

  int? get mcq => _parseMark(mcqController.text);

  int? get theory => _parseMark(theoryController.text);

  int? get practical => _parseMark(practicalController.text);

  bool get isPending =>
      mcqController.text.trim().isEmpty &&
          theoryController.text.trim().isEmpty &&
          practicalController.text.trim().isEmpty;

  int get total => (mcq ?? 0) + (theory ?? 0) + (practical ?? 0);

  bool get isComplete {
    final mcqMark = mcq;
    final theoryMark = theory;
    final practicalMark = practical;

    return mcqMark != null &&
        theoryMark != null &&
        practicalMark != null &&
        mcqMark >= 0 &&
        mcqMark <= 25 &&
        theoryMark >= 0 &&
        theoryMark <= 50 &&
        practicalMark >= 0 &&
        practicalMark <= 25;
  }

  int? _parseMark(String value) {
    if (value.trim().isEmpty) return null;
    return int.tryParse(value.trim());
  }

  void dispose() {
    mcqController.dispose();
    theoryController.dispose();
    practicalController.dispose();
  }
}
