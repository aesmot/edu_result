import 'package:flutter/material.dart';

import '../domain/models/subject.dart';
import 'class_badge.dart';
import 'subject_chip.dart';

class ClassCard extends StatelessWidget {
  final String className;
  final List<Subject> subjects;
  final String? selectedSubjectId;
  final ValueChanged<String?> onSelect;
  final ValueChanged<Subject> onDelete;
  final VoidCallback onAdd;

  const ClassCard({
    super.key,
    required this.className,
    required this.subjects,
    required this.selectedSubjectId,
    required this.onSelect,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1.5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClassBadge(className: className, count: subjects.length),
                const SizedBox(width: 14),
                Expanded(
                  child: subjects.isEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'কোনো সাবজেক্ট নেই',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  )
                      : Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: subjects.map((subject) {
                      final isSelected = selectedSubjectId == subject.id;
                      return SubjectChip(
                        name: subject.name,
                        isSelected: isSelected,
                        onTap: () =>
                            onSelect(isSelected ? null : subject.id),
                        onDelete: () => onDelete(subject),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded,
                          size: 14, color: Color(0xFF2563EB)),
                      SizedBox(width: 4),
                      Text(
                        'Add Subject',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}