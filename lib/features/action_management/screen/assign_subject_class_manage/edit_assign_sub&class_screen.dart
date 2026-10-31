import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../widget/assign_subject&class/assign_edit_card.dart';



class EditAssignSubClassScreen extends StatefulWidget {
  final String assignmentId;
  final String teacherName;
  final String className;
  final String subjectName;

  const EditAssignSubClassScreen({
    super.key,
    this.assignmentId = '',
    this.teacherName = '',
    this.className = '',
    this.subjectName = '',
  });

  @override
  State<EditAssignSubClassScreen> createState() =>
      _EditAssignSubClassScreenState();
}

class _EditAssignSubClassScreenState
    extends State<EditAssignSubClassScreen> {
  late String? selectedTeacher;
  late String? selectedClass;
  late String? selectedSubject;

  // Temporary dummy data.
  // Later these lists will come from Supabase.

  final List<String> teachers = [
    'Mawlana Abdur Rahman',
    'Mohammad Ali',
    'Abdul Karim',
  ];

  final List<String> classes = [
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9 (Dakhil)',
    'Class 10 (Dakhil)',
  ];

  final List<String> subjects = [
    'Al-Hadith',
    'Arabic Grammar',
    'Al-Quran',
    'Fiqh',
  ];

  @override
  void initState() {
    super.initState();

    selectedTeacher = widget.teacherName;
    selectedClass = widget.className;
    selectedSubject = widget.subjectName;

    // Keep existing assignment values available in dropdowns.
    if (!teachers.contains(selectedTeacher)) {
      teachers.add(selectedTeacher!);
    }

    if (!classes.contains(selectedClass)) {
      classes.add(selectedClass!);
    }

    if (!subjects.contains(selectedSubject)) {
      subjects.add(selectedSubject!);
    }
  }

  void _updateAssignment() {
    if (selectedTeacher == null ||
        selectedClass == null ||
        selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select all fields.'),
        ),
      );
      return;
    }

    // Actual Supabase update will be implemented later.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Assignment updated successfully.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),

      appBar: UserAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: AssignEditCard(
              selectedTeacher: selectedTeacher,
              selectedClass: selectedClass,
              selectedSubject: selectedSubject,

              teacherItems: teachers.map((teacher) {
                return DropdownMenuItem<String>(
                  value: teacher,
                  child: Text(teacher),
                );
              }).toList(),

              classItems: classes.map((className) {
                return DropdownMenuItem<String>(
                  value: className,
                  child: Text(className),
                );
              }).toList(),

              subjectItems: subjects.map((subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),

              onTeacherChanged: (value) {
                setState(() {
                  selectedTeacher = value;
                });
              },

              onClassChanged: (value) {
                setState(() {
                  selectedClass = value;
                  // Later subject list will update from class_subjects.
                  selectedSubject = null;
                });
              },

              onSubjectChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },

              onUpdate: _updateAssignment,

              onCancel: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}