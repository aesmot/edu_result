
import 'package:flutter/material.dart';

import 'package:result_management_system/features/action_management/widget/teacher/teacher_card_item.dart';
import 'package:result_management_system/features/teacher/model/teacher_model.dart';
import 'package:result_management_system/features/action_management/screen/teacher_manage/add_edit_teacher_screen.dart';

import '../../../shared/widgets/app_bar.dart';

class TeacherListScreen extends StatelessWidget {
  TeacherListScreen({super.key});

  final List<StaffModel> staffList = [
    StaffModel(
      id: '1',
      name: 'Abdullah Rahman',
      designation: 'Assistant Professor',
      employeeId: 'FAC-MATH-014',
      email: 'abdullah@example.com',
      phone: '+880 1786-876860',
      imageUrl:
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
    ),
    StaffModel(
      id: '2',
      name: 'Sara Khan',
      designation: 'Lecturer',
      employeeId: 'FAC-PHYS-021',
      email: 'sara@example.com',
      phone: '+880 1675-123456',
      imageUrl:
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const UserAppBar(),
      body: Column(
        children: [
          // Add Teacher Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const AddEditTeacherScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Teacher'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Teacher List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                return TeacherCardItem(
                  serialNumber: index + 1,
                  staff: staffList[index],
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const AddEditTeacherScreen(),
                      ),
                    );
                  },
                  onDelete: () {
                    // Delete action will be implemented later.
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
