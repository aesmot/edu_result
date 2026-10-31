
import 'package:flutter/material.dart';

import 'assign_action_button.dart';
import 'assign_dropdown.dart';
import 'assign_dropdown.dart';
import 'assign_action_button.dart';

class AssignEditCard extends StatelessWidget {
  final String? selectedTeacher;
  final String? selectedClass;
  final String? selectedSubject;

  final List<DropdownMenuItem<String>> teacherItems;
  final List<DropdownMenuItem<String>> classItems;
  final List<DropdownMenuItem<String>> subjectItems;

  final ValueChanged<String?> onTeacherChanged;
  final ValueChanged<String?> onClassChanged;
  final ValueChanged<String?> onSubjectChanged;

  final VoidCallback onUpdate;
  final VoidCallback onCancel;

  final bool isLoading;

  const AssignEditCard({
    super.key,
    required this.selectedTeacher,
    required this.selectedClass,
    required this.selectedSubject,
    required this.teacherItems,
    required this.classItems,
    required this.subjectItems,
    required this.onTeacherChanged,
    required this.onClassChanged,
    required this.onSubjectChanged,
    required this.onUpdate,
    required this.onCancel,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Update Assignment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Modify teacher, class and subject information.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 24),

          AssignDropdown<String>(
            label: 'Teacher Name',
            value: selectedTeacher,
            items: teacherItems,
            onChanged: onTeacherChanged,
            hint: 'Select teacher',
          ),

          const SizedBox(height: 18),

          AssignDropdown<String>(
            label: 'Class',
            value: selectedClass,
            items: classItems,
            onChanged: onClassChanged,
            hint: 'Select class',
          ),

          const SizedBox(height: 18),

          AssignDropdown<String>(
            label: 'Subject',
            value: selectedSubject,
            items: subjectItems,
            onChanged: onSubjectChanged,
            hint: 'Select subject',
          ),

          const SizedBox(height: 28),

          AssignActionButton(
            title: 'Update Assignment',
            onPressed: onUpdate,
            isLoading: isLoading,
          ),

          const SizedBox(height: 10),

          AssignActionButton(
            title: 'Cancel',
            onPressed: onCancel,
            isPrimary: false,
          ),
        ],
      ),
    );
  }
}
