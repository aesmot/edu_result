
import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_bar.dart';
import '../../../examination/widgets/examination_dropdown.dart';
import '../widgets/dashboard_stats_grid.dart';
import '../widgets/dashboard_quick_actions.dart';
import '../widgets/recent_activity_section.dart';
import '../../../examination/widgets/examination_dropdown.dart';

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() =>
      _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  String? selectedExaminationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            const Text(
              'Teacher Dashboard Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            //const SizedBox(height: 16),
            //const DashboardStatsGrid(),

            const SizedBox(height: 24),
            ExaminationDropdown(
              selectedExaminationId: selectedExaminationId,
              onChanged: (examination) {
                setState(() {
                  selectedExaminationId = examination?.id;
                });
              },
            ),

            const SizedBox(height: 16),
            const DashboardQuickActions(),

            const SizedBox(height: 24),
            const RecentActivitySection(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(items: [



        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Result',
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),


      ],),
    );
  }
}
