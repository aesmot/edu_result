import 'package:flutter/material.dart';
import 'package:result_management_system/features/teacher/dashboard/widgets/quick_actions/subject_chip.dart';


import '../../provider/teacher_class_provider.dart';
import 'add_subject_dropdown.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({
    required this.teacherClass,
    required this.isSelected,
    required this.selectedSubjectId,
    required this.availableSubjects,
    required this.busy,
    required this.onSelectSubject,
    required this.onAddSubject,
    required this.onRemoveSubject,
    required this.onDeleteClass,
  });

  final TeacherClass teacherClass;
  final bool isSelected;
  final int? selectedSubjectId;
  final List<SubjectOption> availableSubjects;
  final bool busy;
  final void Function(TeacherSubject subject) onSelectSubject;
  final void Function(int classSubjectId) onAddSubject;
  final void Function(TeacherSubject subject) onRemoveSubject;
  final VoidCallback onDeleteClass;

  // ক্লাসের নাম থেকে সংখ্যা বের করা (যেমন "Class 9 (Dakhil)" থেকে "9")
  String get _badgeText {
    final match = RegExp(r'\d+').firstMatch(teacherClass.className);
    if (match != null) return match.group(0)!;
    return teacherClass.className.isNotEmpty
        ? teacherClass.className[0].toUpperCase()
        : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      color: isSelected ? const Color(0xFFE8F1FC) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // বাম পাশে ক্লাস নম্বর
            const SizedBox(width: 12),

            // ডান পাশে ক্লাসের নাম, বিষয়ের chip ও বিষয় যোগের ড্রপডাউন
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          teacherClass.className,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: busy ? null : onDeleteClass,
                        child: const Padding(
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      ...teacherClass.subjects.map((subject) {
                        final isSubjectSelected =
                            isSelected && selectedSubjectId == subject.id;
                        return SubjectChip(
                          label: subject.name,
                          selected: isSubjectSelected,
                          onTap: () => onSelectSubject(subject),
                          onRemove: busy ? null : () => onRemoveSubject(subject),
                        );
                      }),
                      if (availableSubjects.isNotEmpty)
                        AddSubjectDropdown(
                          options: availableSubjects,
                          enabled: !busy,
                          onSelected: onAddSubject,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}