
import 'package:flutter/material.dart';

import '../../widget/teacher_list_screen.dart';


class ManageTeachersScreen extends StatelessWidget {
  const ManageTeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Teachers'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: TeacherListScreen(),
        ),
      ),
    );
  }
}
