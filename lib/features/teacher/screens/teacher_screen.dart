import 'package:flutter/material.dart';
import '../model/teacher_model.dart';
import '../widgets/teacher_card_item.dart';

class TeacherListScreen extends StatelessWidget {
  TeacherListScreen({Key? key}) : super(key: key);

  final List<StaffModel> staffList = [
    StaffModel(
      id: '1',
      name: 'Abdullah Rahman',
      designation: 'Assistant Professor',
      employeeId: 'FAC-MATH-014',
      email: 'abdullah@example.com',
      phone: '+880 1786-876860',
      imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
    ),
    StaffModel(
      id: '2',
      name: 'Sara Khan',
      designation: 'Lecturer',
      employeeId: 'FAC-PHYS-021',
      email: 'sara@example.com',
      phone: '+880 1675-123456',
      imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Staff List'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: staffList.length,
        itemBuilder: (context, index) {
          return TeacherCardItem(
            serialNumber: index + 1,
            staff: staffList[index],
            onEdit: () {
              // Handle edit
            },
            onDelete: () {
              // Handle delete
            },
          );
        },
      ),
    );
  }
}