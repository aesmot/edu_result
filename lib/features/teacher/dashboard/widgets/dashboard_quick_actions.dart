import 'package:flutter/material.dart';

import '../../../mark_entry/presentation/screens/mark_entry_screen.dart';
import '../../../result_view/presentation/screens/teacher_result_screen.dart';

// [NOTE: Tomar enter marks page-er file-ti ekhane import kore nibe, jodi alada file-e thake]
// import 'enter_marks_page.dart';

class DashboardQuickActions extends StatefulWidget {
  const DashboardQuickActions({super.key});

  @override
  State<DashboardQuickActions> createState() =>
      _DashboardQuickActionsState();
}

class _DashboardQuickActionsState
    extends State<DashboardQuickActions> {
  String? selectedClass;
  String? selectedSubject;

  final List<String> classes = [
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  final Map<String, List<String>> subjects = {
    '6': ['Bangla', 'English', 'Mathematics'],
    '7': ['Bangla', 'English', 'Mathematics'],
    '8': ['Bangla', 'English', 'Mathematics'],
    '9': [
      'Bangla',
      'English',
      'Mathematics',
      'ICT',
      'Science',
      'BGS',
    ],
    '10': ['Bangla', 'English', 'Mathematics'],
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Classes & Subjects Combined
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ColumnHeader(title: 'Classes & Subjects'),
              const SizedBox(height: 12),
              ...classes.map((className) {
                final isClassSelected = selectedClass == className;
                final classSubjects = subjects[className] ?? [];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: isClassSelected
                          ? const Color(0xFF3B82F6)
                          : Colors.grey.shade300,
                      width: isClassSelected ? 1.5 : 1,
                    ),
                  ),
                  color: isClassSelected
                      ? const Color(0xFFE8F1FC)
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left side: Large Class Number Box
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3E4FD),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            className.trim(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D4ED8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Right side: Class Name & Subjects Chips
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Class $className',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: classSubjects.map((subject) {
                                  final isSubjectSelected =
                                      isClassSelected &&
                                          selectedSubject == subject;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedClass = className;
                                        selectedSubject = subject;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: isSubjectSelected
                                            ? const Color(0xFF2563EB)
                                            : Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                          color: isSubjectSelected
                                              ? const Color(0xFF2563EB)
                                              : Colors.grey.shade400,
                                        ),
                                      ),
                                      child: Text(
                                        subject,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: isSubjectSelected
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 4),
              OutlinedButton.icon(
                onPressed: () {
                  _showMessage('Select a class from Admin class list');
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Class'),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Column 2: Manage Results (Reusable Component used here)
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ColumnHeader(title: 'Manage Results'),
              const SizedBox(height: 12),
              _ManageResultCard(
                selectedClass: selectedClass,
                selectedSubject: selectedSubject,
                onEnterMarks: () {
                  // Navigation to EnterMarksPage when clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MarkEntryScreen(), // Ensure EnterMarksPage is defined or imported
                    ),
                  );
                },
                onViewResults: () {
                  // === [EI LINE GULO CHANGE KORO] ===
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherResultScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// Reusable Column Header Widget
class _ColumnHeader extends StatelessWidget {
  const _ColumnHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3FE),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFC7D7FE),
          width: 1.2,
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _ManageResultCard extends StatelessWidget {
  const _ManageResultCard({
    required this.selectedClass,
    required this.selectedSubject,
    required this.onEnterMarks,
    required this.onViewResults,
  });

  final String? selectedClass;
  final String? selectedSubject;
  final VoidCallback onEnterMarks;
  final VoidCallback onViewResults;

  @override
  Widget build(BuildContext context) {
    if (selectedClass != null && selectedSubject != null) {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.purple.shade100, width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.assignment_rounded,
                      color: Color(0xFF8B5CF6),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Class $selectedClass',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedSubject!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(height: 1, color: Color(0xFFE5E7EB)),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onEnterMarks,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.edit_note, size: 18),
                  label: const Text(
                    'Enter Marks',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onViewResults,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Color(0xFF8B5CF6)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF8B5CF6)),
                  label: const Text(
                    'View Results',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF8B5CF6)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey.shade400, size: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Select a class and subject to manage results.',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}