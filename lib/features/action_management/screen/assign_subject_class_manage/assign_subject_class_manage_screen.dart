import 'package:flutter/material.dart';
import 'package:result_management_system/shared/widgets/app_bar.dart';

import 'assigned_card_Item.dart';
import 'edit_assign_sub&class_screen.dart';

// Dummy Model class for Assignment Data
class TeacherAssignmentModel {
  final String id;
  final String teacherName;
  final String className;
  final String subjectName;


  TeacherAssignmentModel({
    required this.id,
    required this.teacherName,
    required this.className,
    required this.subjectName,

  });
}

class AssignClassSubjectScreen extends StatefulWidget {
  const AssignClassSubjectScreen({super.key});

  @override
  State<AssignClassSubjectScreen> createState() => _AssignClassSubjectScreenState();
}

class _AssignClassSubjectScreenState extends State<AssignClassSubjectScreen> {
  // Dummy data list
  final List<TeacherAssignmentModel> assignments = [
    TeacherAssignmentModel(
      id: '1',
      teacherName: 'Mawlana Abdur Rahman',
      className: 'Class 9 (Dakhil)',
      subjectName: 'Al-Hadith',
     // imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
    ),
    TeacherAssignmentModel(
      id: '2',
      teacherName: 'Mohammad Ali',
      className: 'Class 6',
      subjectName: 'Arabic Grammar',
     // imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: UserAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            const Text(
              'CURRENT ASSIGNED SUBJECT FOR TEACHER',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),

            // Assignment List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: assignments.length,
              itemBuilder: (context, index) {
                final item = assignments[index];
                return AssignedCardItem(
                  serialNumber: index + 1,
                  teacherName: item.teacherName,
                  className: item.className,
                  subjectName: item.subjectName,

                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAssignSubClassScreen(
                          assignmentId: item.id,
                          teacherName: item.teacherName,
                          className: item.className,
                          subjectName: item.subjectName,
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    // Delete action
                  }, assignmentId: '',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}