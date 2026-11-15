import 'package:flutter/material.dart';
import 'package:result_management_system/features/teacher/dashboard/widgets/quick_actions/subject_chip.dart';

import '../../provider/teacher_class_provider.dart';
import 'add_subject_dropdown.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
    required this.teacherClass,
    required this.isSelected,
    required this.selectedSubjectId,
    required this.availableSubjects,
    required this.busy,
    required this.onSelectSubject,
    required this.onAddSubject,
    required this.onRemoveSubject,
    required this.onSelectClass,
  });

  final TeacherClass teacherClass;
  final bool isSelected;
  final int? selectedSubjectId;
  final List<SubjectOption> availableSubjects;
  final bool busy;
  final void Function(TeacherSubject subject) onSelectSubject;
  final void Function(int classSubjectId) onAddSubject;
  final void Function(TeacherSubject subject) onRemoveSubject;
  final VoidCallback onSelectClass;

  static const _blue = Color(0xFF2563EB);

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
    return GestureDetector(
      onTap: onSelectClass,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3F8FF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _blue : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ক্লাস নম্বর ব্যাজ
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFE0EDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _badgeText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _blue,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ক্লাসের নাম, তার নিচে সাবজেক্ট চিপ ও যোগের ড্রপডাউন
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 42,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        teacherClass.className,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),
                  if (teacherClass.subjects.isNotEmpty ||
                      availableSubjects.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...teacherClass.subjects.map((subject) {
                          final isSubjectSelected =
                              isSelected && selectedSubjectId == subject.id;
                          return SubjectChip(
                            label: subject.name,
                            selected: isSubjectSelected,
                            onTap: () => onSelectSubject(subject),
                            onRemove:
                            busy ? null : () => onRemoveSubject(subject),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}